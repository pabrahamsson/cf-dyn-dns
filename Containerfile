
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:411b34db024ce2aa69eb30dc1332506ba4e43d8d3e079a958ab0d72df827cd51 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:fe49c1e94db2743f99ea08d7bec7b7326595130463f76dd32308e6e122361149
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
