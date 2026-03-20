
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:a8cc68e63e94183f92e81e49c91c37a1554a3c09ade68fa9737a076600d31b1e AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:27aa27aa97fc2c6ca6fb30b82ff9dc528f584e2614412f7739070ffb38ebb753
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
