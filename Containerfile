
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:083147c84a98dbec27dc59a39569bc8634f86302fd9aafcbd5d54525bb317a1d AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:98c869c46372eca60124fcd887db1e35f0cb0ef259a7f2d90cf14eb7920c9103
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
