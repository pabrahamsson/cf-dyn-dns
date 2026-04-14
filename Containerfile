
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:97ca5d2a1da2e5abeb2893cf5714e52253d316ed4d8c17b9e946996e95f1b419 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:533af462b99ab9a4750899c2217332bb4fb1dfe67cf370ae682d824f857ced76
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
