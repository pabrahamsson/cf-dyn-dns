
# Build the manager binary
FROM registry.access.redhat.com/ubi10/go-toolset:10.1-1769070420@sha256:46c65f0a0b9dd5802490fb7908e8a99c037bb7633fcc66fd84a05982ac07cc6f AS builder
ARG TARGETOS=linux
ARG TARGETARCH=amd64
ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

# Copy the code
WORKDIR /opt/app-root/src
COPY . .

RUN export CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH} && \
  go build -buildvcs=false . 
RUN ls -al

FROM registry.access.redhat.com/ubi10/ubi-micro:10.1-1769518576@sha256:551f8ee81be3dbabd45a9c197f3724b9724c1edb05d68d10bfe85a5c9e46a458

ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

ENV GOTRACEBACK=all

WORKDIR /

COPY --from=builder /opt/app-root/src/cf-dyn-dns /cf-dyn-dns

USER 1001
ENTRYPOINT ["/cf-dyn-dns"]
