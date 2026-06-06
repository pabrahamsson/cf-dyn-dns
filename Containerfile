
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:1aaf9b36aad0fc7d2cde864bd4041605696da0a4ffd9d7c2eebc0af9238fdbc8 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:a71de5cc9a2f0d59a606993c43708ee700e5c7fbe997020cb9b31c7d12268b9d
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
