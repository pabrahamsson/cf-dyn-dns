
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:053da9c6e7e5234362b167163057f328b04aaf69a3baaf775315101e2fa5f52a AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:71993808c91eb67af437cbd08eb03e997b80c6ebb8a376693eb113165b837cec
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
