
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:c4a4af58f5a22a8570c10ea121b06fe6907984d3fc72814d474bca1c4333fb8a AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:3684aec36bb5cb0ca62ac911578fc9a99f9ad6d397ee69da4cefecedac669688
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
