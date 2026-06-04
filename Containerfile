
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:433377461114118a3466e4acd8807c3a53b14a5d855909c9eb927273ef9d6c9a AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:c85f5e01b7f638cb30e75a8a79d06b0cbeb44209945f62572166448bb56b53e9
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
