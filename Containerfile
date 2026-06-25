
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:d444a0ceb7d486319e4b15c87ad0ff3a90ef2fe37c01d71cc004649755738d97 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:02ca768db83eda71f60e3dec80ec31438a78a38b376975390cd332a3658f7478
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
