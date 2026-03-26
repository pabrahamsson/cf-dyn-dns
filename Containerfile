
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:58ab27718af699ee06e6638fb09ffd497b0a407e492981f875cd6adc63f6649b AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:f79f47d76ea5cf78ddb722b4719a22c82d74bbbf1c44e2287a414100d01aad54
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
