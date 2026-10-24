
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:4d08575d39b4836eca71ac7848fc1e3a12c96932af9816eee87a382eb45eabee AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:12ebc4493ccbb80fd47175c9c670ea590c4e7140a7c4858e038ac2df42be8ca8
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
