
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:6d94a42757e9acd97bc408cb32997f1d2399ded7709d55d0fff5a467d964c99a AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:0ad4060562831e0c724d5f2d5b0e38ed5e6a8c4e8b4c69d35404bb66e7f45edf
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
