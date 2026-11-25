
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:246cf9c8f3e8c7d908e8bdcc1a8cdf978f2beca93637127deb204b574ae13984 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:fe49c1e94db2743f99ea08d7bec7b7326595130463f76dd32308e6e122361149
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
