
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:cdef29626fcb59209c8a96b79f77fb49ab1bf353003875ac3386c8304896f585 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:a71de5cc9a2f0d59a606993c43708ee700e5c7fbe997020cb9b31c7d12268b9d
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
