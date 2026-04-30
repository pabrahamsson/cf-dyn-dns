
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:0fb41e012a22aa95eaad2e46c1d9e3ca9ca0b241231b9be02f9f35c7a065da1c AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:3f6c9eab103ffad720369d91ae7e942bc42d1a226de8c148530e23c132cef96b
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
