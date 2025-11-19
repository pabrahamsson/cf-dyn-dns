
# Build the manager binary
FROM registry.access.redhat.com/ubi10/go-toolset:10.1-1763548447@sha256:b0bd9b5760009ae4ccfb23b0f0d60fe7c3dd74be9f6a3f7b1097e30c789431e9 AS builder
ARG TARGETOS=linux
ARG TARGETARCH=amd64
ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

# Copy the code
WORKDIR /opt/app-root/src
COPY . .

RUN export CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH} && \
  go build -buildvcs=false . 
RUN ls -al

FROM registry.access.redhat.com/ubi10/ubi-micro:10.1-1763138307@sha256:fc8e116afac12a9164be775e21483da7b6e86f91d8e9e6e79dee23afe4e58468

ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

ENV GOTRACEBACK=all

WORKDIR /

COPY --from=builder /opt/app-root/src/cf-dyn-dns /cf-dyn-dns

USER 1001
ENTRYPOINT ["/cf-dyn-dns"]
