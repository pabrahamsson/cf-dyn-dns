
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:6ba7fb93a5f9fa48402b249a9c1a9ae3a074cb573bf7c74aae40f78c3d6a72bf AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:27aa27aa97fc2c6ca6fb30b82ff9dc528f584e2614412f7739070ffb38ebb753
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
