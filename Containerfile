
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:e0215c751b043585fb6e3838079f6ab64f381dccf927a2a6e77fe6e97722b944 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:140e148b1662d2007bf427e5c052023fcaa6c2a08559fb58917220317e6debcc
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
