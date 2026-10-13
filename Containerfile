
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:c928ea1c9b29e092cb679614a7a0c114f6a614a6c808772d419db5330037d494 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:4730fe5f23bec7eb86b9736bc1458d58862372b1d1555ca9da77d21d4fffea17
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
