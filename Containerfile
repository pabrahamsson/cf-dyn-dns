
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:ebc0a02e3b1b8fae63a4206a76eeff84ef5c0520fbeb5f7666e6adc5a429c924 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:9671a7668f2a0a041d90174dec5cd15eba7ad34227363630d3fea11efa986a41
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
