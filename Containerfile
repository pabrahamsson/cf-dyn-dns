
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:fc737660762a665df555c8a263bd6a1d1cefde16c80e80c321ce1ecd5645b1be AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:1171ea7227d7c06e2cce4b000c0e7f3d31c216fffd3bd7ad6e8dcc56de2a217f
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
