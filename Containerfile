
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:c3232e7b7e60af7667884ba6fc12ce1285402fb82d9fe975c80b127139567486 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:3fadedf666f137f7d36a673fcf215307bf19bc56c12eb6a323674606eac3c5bf
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
