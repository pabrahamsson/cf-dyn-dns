
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:d025e07c83ec50b1a1a3611d8a33d755b99ff51e016f319c509fb11c0def4584 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:58f9030ce520821c61798d41ca52aa2b10ba5f20c49245f63ecffcfcaa3d464f
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
