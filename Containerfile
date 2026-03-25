
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:39e0525c3ea291d50ddcf159910a07c0d41ff79f6ba9f4e8c7328aef3feb9704 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:f79f47d76ea5cf78ddb722b4719a22c82d74bbbf1c44e2287a414100d01aad54
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
