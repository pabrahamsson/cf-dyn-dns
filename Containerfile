
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:3a71bed22e4561b81e96318f9433b14c11d10066823360dd9dfd29a6a808beff AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:c85f5e01b7f638cb30e75a8a79d06b0cbeb44209945f62572166448bb56b53e9
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
