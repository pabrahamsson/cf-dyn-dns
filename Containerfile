
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:23a9a544e1c9a8d6b8aed12d671a4620c43536660f9177882cfa08cfdb850fc1 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:8e597a23a81b65132b7d64d827eb723b035324ec4565ab7aed442540ffbc0841
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
