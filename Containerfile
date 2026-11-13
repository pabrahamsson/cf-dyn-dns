
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:4df53fbf5e5475b680929a90238767c40ca2cce209037b7b01bdb4695880d8ee AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:81280d7fd6afa7a3d2a6da2e90e545cf8e5d187c80a69b2a1c875fdcd731aaed
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
