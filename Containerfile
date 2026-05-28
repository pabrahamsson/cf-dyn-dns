
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:6bc8aae21eca50925513b4905c8740da8cb6818e3ff0ebc56d09f78f8812b6da AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:c85f5e01b7f638cb30e75a8a79d06b0cbeb44209945f62572166448bb56b53e9
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
