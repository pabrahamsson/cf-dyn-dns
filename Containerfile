
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:97ca5d2a1da2e5abeb2893cf5714e52253d316ed4d8c17b9e946996e95f1b419 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:58a417eb4978e8f57c97506e7a6930091a0b8ba9904e79d4196ef5a3447936fa
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
