
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:0fb41e012a22aa95eaad2e46c1d9e3ca9ca0b241231b9be02f9f35c7a065da1c AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:0c9a240d8f0e23a113b2aad77b25449fac259a37b9c080e1f6410261e51b1e11
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
