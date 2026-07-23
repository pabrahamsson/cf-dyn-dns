
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:3a459a6019fe7d7693af3ed8c2dde8d7ce2a105e42e13e1f4cc177d8486e89a6 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:8792ecb75763b6a2f783e048722d87bcf41b9479dafe4c6d7f275781b91e9196
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
