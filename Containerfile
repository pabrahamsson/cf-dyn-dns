
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:083147c84a98dbec27dc59a39569bc8634f86302fd9aafcbd5d54525bb317a1d AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:3f6c9eab103ffad720369d91ae7e942bc42d1a226de8c148530e23c132cef96b
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
