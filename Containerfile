
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:a2755908d67e2be26eb35e004bb6d6909e67080e77ff4af52db49e7ce1685a97 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:533af462b99ab9a4750899c2217332bb4fb1dfe67cf370ae682d824f857ced76
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
