
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:9a24b13a9b4d7f0c2810c76035452159c34c0b7ccb527699e99c4ee11ea13337 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:12ebc4493ccbb80fd47175c9c670ea590c4e7140a7c4858e038ac2df42be8ca8
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
