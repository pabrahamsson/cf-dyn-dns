
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:c928ea1c9b29e092cb679614a7a0c114f6a614a6c808772d419db5330037d494 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:12ebc4493ccbb80fd47175c9c670ea590c4e7140a7c4858e038ac2df42be8ca8
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
