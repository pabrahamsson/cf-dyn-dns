
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:a2755908d67e2be26eb35e004bb6d6909e67080e77ff4af52db49e7ce1685a97 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:140e148b1662d2007bf427e5c052023fcaa6c2a08559fb58917220317e6debcc
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
