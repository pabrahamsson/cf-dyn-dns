
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:246cf9c8f3e8c7d908e8bdcc1a8cdf978f2beca93637127deb204b574ae13984 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:33539044661f70521596967ee6581b12cc49c30c9f93bf5c52b622d2e9aa8b01
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
