
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:ed97ed1cd597207baec4a3c9f8caecc7e77be3a19ee1426beece09656821a8f3 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:fa72c318cd10f62b5616f396df0493ad8531adf0841aaf7b5d89c323712cfa11
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
