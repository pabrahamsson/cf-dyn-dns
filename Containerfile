
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:a8cc68e63e94183f92e81e49c91c37a1554a3c09ade68fa9737a076600d31b1e AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:62dc6d45256cd3e1f720ad44c8c38fb2632a16e7e934a482d687016b08a61857
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
