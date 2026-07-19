
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:d1c6067b6538ae54fda70c6cf4d93ceb411cbc1ba38a27a50276b237253eaef2 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:b437b9e46e5f43372fcbf53fab38242ef68638f0f57cd846d243f958cfbc029f
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
