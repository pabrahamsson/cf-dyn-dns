
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:fbda9826f239d94c04cedd5319bcce18ea419296374ad02966be58154a51be51 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:33539044661f70521596967ee6581b12cc49c30c9f93bf5c52b622d2e9aa8b01
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
