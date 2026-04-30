
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:0fb41e012a22aa95eaad2e46c1d9e3ca9ca0b241231b9be02f9f35c7a065da1c AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:98c869c46372eca60124fcd887db1e35f0cb0ef259a7f2d90cf14eb7920c9103
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
