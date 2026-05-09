
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:bbaa3ee2135ab54ecfef7334af954264a1e0e90d8c56e4acbb4ce0b43b0122ff AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:0ad4060562831e0c724d5f2d5b0e38ed5e6a8c4e8b4c69d35404bb66e7f45edf
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
