
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:3a459a6019fe7d7693af3ed8c2dde8d7ce2a105e42e13e1f4cc177d8486e89a6 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:b437b9e46e5f43372fcbf53fab38242ef68638f0f57cd846d243f958cfbc029f
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
