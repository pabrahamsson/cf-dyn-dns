
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:7d5f69b79eebbb230b81ac06417ffe43034f2f4cc7aa51a866239d03809fdc33 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:08ede4ddf55f824f96a3b55eba02097f66c2c1d9693523bd5e94de59b3359b9e
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
