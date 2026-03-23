
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:54a1de507f1b0bf50ba1e1bc5e355c32b0691ff563863cc239331d8e1c981d4e AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:27aa27aa97fc2c6ca6fb30b82ff9dc528f584e2614412f7739070ffb38ebb753
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
