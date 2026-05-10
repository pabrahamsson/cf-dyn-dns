
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:0d24804172d2c2f50c2f1927a84a1fb889a617e396f29c776f9f071271661fd2 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:8a0d72d68b9ae89e673594f9b4647e630b2cce3aa3a0fa7272eb988b72f88de3
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
