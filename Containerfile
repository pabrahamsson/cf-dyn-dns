
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:d1c6067b6538ae54fda70c6cf4d93ceb411cbc1ba38a27a50276b237253eaef2 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:b93bfca801245219c332093e1c52a639414154533cecb1522630aeef48710960
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
