
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:716b64023c1e07fd981b49a2db81d2bf18d5841ddbc7dd5d7a56172417d0bdc5 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:974dec56b9fb3d6922ef585ed456d3cc705845002d1b45eeb3bf52314382a740
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
