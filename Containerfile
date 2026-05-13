
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:95f1cccb2b72fa2c4b2fb382ee2358fe6ab2c69279106886a5d9ef24a792f6a8 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:c2b8b0a4b588ce91b058b89dc6d50b6049b11dd879e98697974c92c0c6325026
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
