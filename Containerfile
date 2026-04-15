
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:2643c11a50efe9281ebd5357b1b1445bf2f7bba16d7ec63e114bf916d468cb3d AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:98c869c46372eca60124fcd887db1e35f0cb0ef259a7f2d90cf14eb7920c9103
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
