
# Build the manager binary
FROM registry.access.redhat.com/ubi10/go-toolset:10.1-1762240400@sha256:9566353b4aadf7286f4d9d892e4285ed38b76ac47353033fdbb7ea0f92689799 AS builder
ARG TARGETOS=linux
ARG TARGETARCH=amd64
ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

# Copy the code
WORKDIR /opt/app-root/src
COPY . .

RUN export CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH} && \
  go build -buildvcs=false . 
RUN ls -al

FROM registry.access.redhat.com/ubi10/ubi-micro:10.1-1762215812@sha256:c2a5841f6fc280b93761e8a55f3de9e5dd861cdcfca8de04a8c574f15fd7acac

ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

ENV GOTRACEBACK=all

WORKDIR /

COPY --from=builder /opt/app-root/src/cf-dyn-dns /cf-dyn-dns

USER 1001
ENTRYPOINT ["/cf-dyn-dns"]
