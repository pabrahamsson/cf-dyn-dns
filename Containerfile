
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:a29ec931ed71924a62238f6f3ab5481a3ebed6157ed30dfac47a223fec9efcef AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:ea4830e9673b85d60f5a47a3390bb58a4a261b949b0a563f74538bb321737561
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
