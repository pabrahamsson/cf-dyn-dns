
# Build the manager binary
FROM registry.access.redhat.com/ubi10/go-toolset:10.1-1767889253@sha256:947962f92cc541358a90d54b8da4a4a313522c7b3f602bd934c559f0cc2d2b19 AS builder
ARG TARGETOS=linux
ARG TARGETARCH=amd64
ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

# Copy the code
WORKDIR /opt/app-root/src
COPY . .

RUN export CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH} && \
  go build -buildvcs=false . 
RUN ls -al

FROM registry.access.redhat.com/ubi10/ubi-micro:10.1-1766049088@sha256:2946fa1b951addbcd548ef59193dc0af9b3e9fedb0287b4ddb6e697b06581622

ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

ENV GOTRACEBACK=all

WORKDIR /

COPY --from=builder /opt/app-root/src/cf-dyn-dns /cf-dyn-dns

USER 1001
ENTRYPOINT ["/cf-dyn-dns"]
