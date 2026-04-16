
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:896690ee5c964f524a9ce277beda912afee24a211c9072c122d50f8a8ccfcff0 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:98c869c46372eca60124fcd887db1e35f0cb0ef259a7f2d90cf14eb7920c9103
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
