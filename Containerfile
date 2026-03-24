
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:39e0525c3ea291d50ddcf159910a07c0d41ff79f6ba9f4e8c7328aef3feb9704 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:27aa27aa97fc2c6ca6fb30b82ff9dc528f584e2614412f7739070ffb38ebb753
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
