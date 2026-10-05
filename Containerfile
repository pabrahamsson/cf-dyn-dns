
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:d025e07c83ec50b1a1a3611d8a33d755b99ff51e016f319c509fb11c0def4584 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:ea4830e9673b85d60f5a47a3390bb58a4a261b949b0a563f74538bb321737561
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
