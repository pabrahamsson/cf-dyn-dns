
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:3a459a6019fe7d7693af3ed8c2dde8d7ce2a105e42e13e1f4cc177d8486e89a6 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:32b71590eef9295afa862261d66f90b9b4c537df59e35684e33a9e6bbae03c5a
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
