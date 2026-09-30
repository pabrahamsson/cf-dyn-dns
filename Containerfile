
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:ebc0a02e3b1b8fae63a4206a76eeff84ef5c0520fbeb5f7666e6adc5a429c924 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:58f9030ce520821c61798d41ca52aa2b10ba5f20c49245f63ecffcfcaa3d464f
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
