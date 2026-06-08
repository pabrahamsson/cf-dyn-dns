
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:b3a5ba18dbc7ac1894b0877a80bf4fbafbccdcfbd9ff07dd8e33da174831f88a AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:a71de5cc9a2f0d59a606993c43708ee700e5c7fbe997020cb9b31c7d12268b9d
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
