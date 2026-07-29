
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:716b64023c1e07fd981b49a2db81d2bf18d5841ddbc7dd5d7a56172417d0bdc5 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:8e597a23a81b65132b7d64d827eb723b035324ec4565ab7aed442540ffbc0841
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
