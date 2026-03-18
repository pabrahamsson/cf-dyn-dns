
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:a8cc68e63e94183f92e81e49c91c37a1554a3c09ade68fa9737a076600d31b1e AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:2f790499a79b5625d8d2d8641c72c8ec3ac30f66d12d78e830e266378276ba5b
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
