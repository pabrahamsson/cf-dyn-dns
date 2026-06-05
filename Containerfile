
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:1aaf9b36aad0fc7d2cde864bd4041605696da0a4ffd9d7c2eebc0af9238fdbc8 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:c85f5e01b7f638cb30e75a8a79d06b0cbeb44209945f62572166448bb56b53e9
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
