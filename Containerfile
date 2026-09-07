
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:fc737660762a665df555c8a263bd6a1d1cefde16c80e80c321ce1ecd5645b1be AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:71993808c91eb67af437cbd08eb03e997b80c6ebb8a376693eb113165b837cec
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
