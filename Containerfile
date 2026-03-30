
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:b6bbee38a741a64c7bc4b1e8a9205f0906926346e673927b87e6df0524a5a65f AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:f79f47d76ea5cf78ddb722b4719a22c82d74bbbf1c44e2287a414100d01aad54
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
