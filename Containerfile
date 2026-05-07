
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:150648d41e4193f81116b280becd12c16d84c192ad26678fa1c33629fbe8dca4 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:0ad4060562831e0c724d5f2d5b0e38ed5e6a8c4e8b4c69d35404bb66e7f45edf
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
