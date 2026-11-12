
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:09ef9cdbf3011e8e4f5514a117cd8e81b1f6184569457ee254b1fcd766fe8746 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:4163796d8b7f28021178093d31cb97c05336fd3f3a4d7006603a7fef29e997e7
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
