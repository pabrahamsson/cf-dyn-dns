
# Build the manager binary
FROM registry.access.redhat.com/ubi10/go-toolset:10.0-1752559364@sha256:fe70b5fe778d7a9bbf85c3640886c15f5f6c6032c8e92532068b22b3ac144240 AS builder
ARG TARGETOS=linux
ARG TARGETARCH=amd64
ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

# Copy the code
WORKDIR /opt/app-root/src
COPY . .

RUN export CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH} && \
  go build -buildvcs=false . 
RUN ls -al

FROM registry.access.redhat.com/ubi10/ubi-micro:10.0-1751898463@sha256:981e886bc096631dcfd3a23593094ff1abaf35d805a73a61d4a4640b7e9a1e04

ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

ENV GOTRACEBACK=all

WORKDIR /

COPY --from=builder /opt/app-root/src/cf-dyn-dns /cf-dyn-dns

USER 1001
ENTRYPOINT ["/cf-dyn-dns"]
