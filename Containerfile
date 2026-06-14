
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:e6d96a936f7236394e2424f667925e1756b48bc421b0af65c206033efbd78e18 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:dcd72eaa2df901c4915e1eec915906c8787c64b9e4149b4211d4500fbbe71791
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
