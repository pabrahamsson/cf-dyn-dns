
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:6f8cd6729235b19035d569864c3eba04ff0d10a9e4229c65c017ac963bbb3a97 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:9666b5aad217d503660028879a72d4a500fbcbff89fcad5d1974e029eb5df4d3
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
