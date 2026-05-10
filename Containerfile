
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:0d24804172d2c2f50c2f1927a84a1fb889a617e396f29c776f9f071271661fd2 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:c2b8b0a4b588ce91b058b89dc6d50b6049b11dd879e98697974c92c0c6325026
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
