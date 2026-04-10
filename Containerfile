
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:ce97a68301f6f5362c2eeeb4f0ea7989e95991bec75ff5b2fc9b38cb94dcf9f2 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:b30b077fbe7d6e65b2dfb80d168772a0f752140c2034b9f93656f0bf291aee7a
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
