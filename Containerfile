
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:16fccc273d34225483088c7f87d7fb27c9d1d148cf21a410ad539ec7152fa0d3 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:1171ea7227d7c06e2cce4b000c0e7f3d31c216fffd3bd7ad6e8dcc56de2a217f
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
