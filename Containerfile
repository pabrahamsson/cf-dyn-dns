
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:4b5537d26ce31ced58deeb599f1990f5b55a533489e58cf6b66918388f250608 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:47c4393878ee5848f91d9538dbe742b8cd04da6d1db80286c293460eeb5b1a6c
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
