
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:37676d96bda9a6ce92f9b5bb64cea2469502934444eea790091a000128a4299f AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:b9bbc03ef0531e5ea1918d1ec259b8414ce369842aba378cbf768a572ee26782
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
