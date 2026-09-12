
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:16fccc273d34225483088c7f87d7fb27c9d1d148cf21a410ad539ec7152fa0d3 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:114d1b0ba3e2a1fc4ef42f8c1a388c6a7a2f8dca42a38a433464d0edb15bd56b
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
