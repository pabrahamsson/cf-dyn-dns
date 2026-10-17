
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:780d920a7f2e768e26b6d3fe95673908ee552e5dbcc45d1a17125c1b06dcf718 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:12ebc4493ccbb80fd47175c9c670ea590c4e7140a7c4858e038ac2df42be8ca8
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
