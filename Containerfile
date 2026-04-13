
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:97ca5d2a1da2e5abeb2893cf5714e52253d316ed4d8c17b9e946996e95f1b419 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:140e148b1662d2007bf427e5c052023fcaa6c2a08559fb58917220317e6debcc
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
