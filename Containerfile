
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:f62efd9062282bf4d74a507b764cccd34e61a197f77363b84015e3a038fb5f8c AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:27aa27aa97fc2c6ca6fb30b82ff9dc528f584e2614412f7739070ffb38ebb753
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
