
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:4a9abade73890ef55b0f55394aedddbb6e9a72f099f82d34af7ea3c1c0d9410a AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:0c9a240d8f0e23a113b2aad77b25449fac259a37b9c080e1f6410261e51b1e11
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
