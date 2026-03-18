
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:35feef8788a42ab5bb41df92d82a0a78273c1a9ddf7cbe0726fae00cc25be9ab AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:2f790499a79b5625d8d2d8641c72c8ec3ac30f66d12d78e830e266378276ba5b
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
