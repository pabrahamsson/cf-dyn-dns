
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:a29ec931ed71924a62238f6f3ab5481a3ebed6157ed30dfac47a223fec9efcef AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:1abbb3f306dd1df28c46415def816056247cf850b861655097d46af971746f9b
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
