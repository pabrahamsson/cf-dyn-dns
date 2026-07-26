
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:23a9a544e1c9a8d6b8aed12d671a4620c43536660f9177882cfa08cfdb850fc1 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:8792ecb75763b6a2f783e048722d87bcf41b9479dafe4c6d7f275781b91e9196
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
