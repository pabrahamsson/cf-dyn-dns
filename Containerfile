
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:c7c22dd96cd2f542e262f22f42601a9ae54f5b9c098dad2f1b7d598f7b9dcebb AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:80bd4bd4e74c8ab4e372cf355b335dbd30d91e9e5669822283299e65c64788e2
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
