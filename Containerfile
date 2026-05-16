
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:95f1cccb2b72fa2c4b2fb382ee2358fe6ab2c69279106886a5d9ef24a792f6a8 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:8e26a551cf67278a00e1c9a007c09d7df60567b92f5ef57372a06fffbbb7b858
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
