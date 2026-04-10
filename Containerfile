
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:d998b4848cca7856c5c0b9f6373a74af210fd7f41809c46e546b2dff9a4bce0a AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:b30b077fbe7d6e65b2dfb80d168772a0f752140c2034b9f93656f0bf291aee7a
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
