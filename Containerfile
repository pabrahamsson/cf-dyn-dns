
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:4f95b1337f1b0a8cc528cb142e897a1d3996b732176592f9982e98cefc2b0c6f AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:4163796d8b7f28021178093d31cb97c05336fd3f3a4d7006603a7fef29e997e7
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
