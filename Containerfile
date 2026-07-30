
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:990373bb0947747bc6cd391015f6175c2730bf5ae620d65a8331d93c41757e91 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:b1cc97b3fee6c84407bea32d4d638a898c160f6682179ef03e56d90af44cfc1f
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
