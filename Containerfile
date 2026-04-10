
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:e0215c751b043585fb6e3838079f6ab64f381dccf927a2a6e77fe6e97722b944 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:b30b077fbe7d6e65b2dfb80d168772a0f752140c2034b9f93656f0bf291aee7a
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
