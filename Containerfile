
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:716b64023c1e07fd981b49a2db81d2bf18d5841ddbc7dd5d7a56172417d0bdc5 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:b1cc97b3fee6c84407bea32d4d638a898c160f6682179ef03e56d90af44cfc1f
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
