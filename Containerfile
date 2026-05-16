
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:17966c46248a87dff32ff463af56a380ba36d8d6a5b243813991fe7207e0ad13 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:8e26a551cf67278a00e1c9a007c09d7df60567b92f5ef57372a06fffbbb7b858
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
