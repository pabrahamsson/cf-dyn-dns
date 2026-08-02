
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:c2c7b0e204a331eb392a60cc1fcdeade8cf881f682f8370e5668c5c70d723328 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:b1cc97b3fee6c84407bea32d4d638a898c160f6682179ef03e56d90af44cfc1f
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
