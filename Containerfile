
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:6f8cd6729235b19035d569864c3eba04ff0d10a9e4229c65c017ac963bbb3a97 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:c85f5e01b7f638cb30e75a8a79d06b0cbeb44209945f62572166448bb56b53e9
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
