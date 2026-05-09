
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:bbaa3ee2135ab54ecfef7334af954264a1e0e90d8c56e4acbb4ce0b43b0122ff AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:8a0d72d68b9ae89e673594f9b4647e630b2cce3aa3a0fa7272eb988b72f88de3
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
