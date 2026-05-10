
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:bbaa3ee2135ab54ecfef7334af954264a1e0e90d8c56e4acbb4ce0b43b0122ff AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:c2b8b0a4b588ce91b058b89dc6d50b6049b11dd879e98697974c92c0c6325026
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
