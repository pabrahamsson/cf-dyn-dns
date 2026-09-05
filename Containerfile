
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:2d3bc7294e35ee9cbe5cdc31ee5ca9caa2cff664967805f46d32b64b3d1499fe AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:71993808c91eb67af437cbd08eb03e997b80c6ebb8a376693eb113165b837cec
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
