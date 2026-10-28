
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:9a24b13a9b4d7f0c2810c76035452159c34c0b7ccb527699e99c4ee11ea13337 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:4163796d8b7f28021178093d31cb97c05336fd3f3a4d7006603a7fef29e997e7
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
