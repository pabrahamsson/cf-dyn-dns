
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:17966c46248a87dff32ff463af56a380ba36d8d6a5b243813991fe7207e0ad13 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:9666b5aad217d503660028879a72d4a500fbcbff89fcad5d1974e029eb5df4d3
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
