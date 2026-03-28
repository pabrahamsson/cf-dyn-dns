
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:58ab27718af699ee06e6638fb09ffd497b0a407e492981f875cd6adc63f6649b AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:eda3d425567952ebbf74a888fe435a9245a8992f4ca0dba427ef5c5c383da652
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
