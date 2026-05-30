
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:ca7aa4333c880e5246593dd56008be52460e8ea3ecce7755bfdfd18e9bcb66f6 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:c85f5e01b7f638cb30e75a8a79d06b0cbeb44209945f62572166448bb56b53e9
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
