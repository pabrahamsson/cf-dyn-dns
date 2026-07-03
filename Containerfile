
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:c3232e7b7e60af7667884ba6fc12ce1285402fb82d9fe975c80b127139567486 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:b93bfca801245219c332093e1c52a639414154533cecb1522630aeef48710960
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
