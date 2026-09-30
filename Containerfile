
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:0682509f458d0ef449f2a3a95e067ecd8fc78bd0d89fc2d0f0cb5d2859908326 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:9671a7668f2a0a041d90174dec5cd15eba7ad34227363630d3fea11efa986a41
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
