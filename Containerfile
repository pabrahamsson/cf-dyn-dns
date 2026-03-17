
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:35feef8788a42ab5bb41df92d82a0a78273c1a9ddf7cbe0726fae00cc25be9ab AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:62dc6d45256cd3e1f720ad44c8c38fb2632a16e7e934a482d687016b08a61857
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
