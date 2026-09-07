
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:053da9c6e7e5234362b167163057f328b04aaf69a3baaf775315101e2fa5f52a AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:114d1b0ba3e2a1fc4ef42f8c1a388c6a7a2f8dca42a38a433464d0edb15bd56b
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
