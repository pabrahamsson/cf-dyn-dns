
# Build the manager binary
FROM registry.access.redhat.com/ubi9/go-toolset:9.5-1747059472 AS builder
ARG TARGETOS=linux
ARG TARGETARCH=amd64
ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

# Copy the code
COPY . .

RUN export CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH} && \
  go build -buildvcs=false .

FROM registry.access.redhat.com/ubi9/ubi-minimal:9.5-1745855087

ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

ENV GOTRACEBACK=all

WORKDIR /

COPY --from=builder /opt/app-root/src/cf-dyn-dns /cf-dyn-dns


ENTRYPOINT ["/cf-dyn-dns"]
