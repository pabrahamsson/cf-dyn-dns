
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:a29ec931ed71924a62238f6f3ab5481a3ebed6157ed30dfac47a223fec9efcef AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:4730fe5f23bec7eb86b9736bc1458d58862372b1d1555ca9da77d21d4fffea17
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
