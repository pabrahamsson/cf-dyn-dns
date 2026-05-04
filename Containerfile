
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:4a9abade73890ef55b0f55394aedddbb6e9a72f099f82d34af7ea3c1c0d9410a AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:3f6c9eab103ffad720369d91ae7e942bc42d1a226de8c148530e23c132cef96b
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
