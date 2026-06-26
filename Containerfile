
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:d444a0ceb7d486319e4b15c87ad0ff3a90ef2fe37c01d71cc004649755738d97 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:47c4393878ee5848f91d9538dbe742b8cd04da6d1db80286c293460eeb5b1a6c
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
