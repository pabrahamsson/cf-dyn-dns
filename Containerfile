
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:6d94a42757e9acd97bc408cb32997f1d2399ded7709d55d0fff5a467d964c99a AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:0c9a240d8f0e23a113b2aad77b25449fac259a37b9c080e1f6410261e51b1e11
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
