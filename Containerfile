
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:ed2ffa394ca0313b8c59b87efb9b08ded60de40b8f94d75635092349713fa1ca AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:8792ecb75763b6a2f783e048722d87bcf41b9479dafe4c6d7f275781b91e9196
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
