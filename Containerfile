
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:4b5537d26ce31ced58deeb599f1990f5b55a533489e58cf6b66918388f250608 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:02ca768db83eda71f60e3dec80ec31438a78a38b376975390cd332a3658f7478
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
