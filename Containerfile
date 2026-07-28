
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:2d3c2eacf9a34161fc130ce100cf1cf36da1a0021add3680afbb703c242fdf4c AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:8e597a23a81b65132b7d64d827eb723b035324ec4565ab7aed442540ffbc0841
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
