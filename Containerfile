
# Build the manager binary
FROM registry.access.redhat.com/ubi10/go-toolset:10.0-1761711009@sha256:a3f517a051e23c585fdb2a836d0c069ee8dd3433e47e917cbc9954351a7a2312 AS builder
ARG TARGETOS=linux
ARG TARGETARCH=amd64
ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

# Copy the code
WORKDIR /opt/app-root/src
COPY . .

RUN export CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH} && \
  go build -buildvcs=false . 
RUN ls -al

FROM registry.access.redhat.com/ubi10/ubi-micro:10.0-1754556444@sha256:2a820c70ceee2588618f4b1b6116eaa38952b455e1f9fd3a91f7d8afb21c0873

ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

ENV GOTRACEBACK=all

WORKDIR /

COPY --from=builder /opt/app-root/src/cf-dyn-dns /cf-dyn-dns

USER 1001
ENTRYPOINT ["/cf-dyn-dns"]
