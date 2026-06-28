
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:4b5537d26ce31ced58deeb599f1990f5b55a533489e58cf6b66918388f250608 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:3fadedf666f137f7d36a673fcf215307bf19bc56c12eb6a323674606eac3c5bf
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
