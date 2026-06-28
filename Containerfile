
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:41c5a5821927c4d59a3433795afdaa47a48142707d29171672ba101e4264cdc4 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:47c4393878ee5848f91d9538dbe742b8cd04da6d1db80286c293460eeb5b1a6c
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
