
# Build the manager binary
FROM registry.access.redhat.com/ubi9/go-toolset:1.21.13-2 AS builder
ARG TARGETOS=linux
ARG TARGETARCH=amd64
ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

# Copy the Go Modules manifests
COPY go.mod go.mod
COPY go.sum go.sum
# cache deps before building and copying source so that we don't need to re-download as much
# and so that source changes don't invalidate our downloaded layer
# RUN go mod download

# Copy the go source
#COPY vendor/ vendor/
COPY main.go main.go
#COPY cmd/ cmd/
#COPY internal/ internal/
#COPY pkg/ pkg/
#COPY .git/ .git/

RUN export CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH} && \
  go build .

FROM registry.access.redhat.com/ubi9/ubi-minimal:9.4-1227.1726694542

ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

ENV GOTRACEBACK=all

WORKDIR /

COPY --from=builder /opt/app-root/src/cf-dyn-dns /cf-dyn-dns


ENTRYPOINT ["/cf-dyn-dns"]
