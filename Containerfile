
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:9f44138f0761dea4864aa070510c1d0e0792ecb7b0c995b213b1630e77dca6ef AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:33539044661f70521596967ee6581b12cc49c30c9f93bf5c52b622d2e9aa8b01
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
