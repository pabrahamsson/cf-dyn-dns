
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:6d94a42757e9acd97bc408cb32997f1d2399ded7709d55d0fff5a467d964c99a AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:8a0d72d68b9ae89e673594f9b4647e630b2cce3aa3a0fa7272eb988b72f88de3
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
