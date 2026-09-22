
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:00345ddf691f62f0f011b4925e99a6bfa69c0303e265c9525e90c0e83f38013e AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:9671a7668f2a0a041d90174dec5cd15eba7ad34227363630d3fea11efa986a41
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
