
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:cdef29626fcb59209c8a96b79f77fb49ab1bf353003875ac3386c8304896f585 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:c85f5e01b7f638cb30e75a8a79d06b0cbeb44209945f62572166448bb56b53e9
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
