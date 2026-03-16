
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:c4a4af58f5a22a8570c10ea121b06fe6907984d3fc72814d474bca1c4333fb8a AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:423948a1cc81bde1b75f553b592f483e12fd246119bcf98f5df41891197d9534
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
