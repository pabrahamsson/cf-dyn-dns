
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:16fccc273d34225483088c7f87d7fb27c9d1d148cf21a410ad539ec7152fa0d3 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:fa72c318cd10f62b5616f396df0493ad8531adf0841aaf7b5d89c323712cfa11
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
