
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:d025e07c83ec50b1a1a3611d8a33d755b99ff51e016f319c509fb11c0def4584 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:4730fe5f23bec7eb86b9736bc1458d58862372b1d1555ca9da77d21d4fffea17
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
