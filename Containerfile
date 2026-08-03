
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:c2c7b0e204a331eb392a60cc1fcdeade8cf881f682f8370e5668c5c70d723328 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:80bd4bd4e74c8ab4e372cf355b335dbd30d91e9e5669822283299e65c64788e2
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
