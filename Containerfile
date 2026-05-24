
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:d8c8b702b8a54150e8fdca86753f581d98c551ab8a3fd429886d4ddd4e949894 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:9666b5aad217d503660028879a72d4a500fbcbff89fcad5d1974e029eb5df4d3
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
