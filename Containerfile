
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:2643c11a50efe9281ebd5357b1b1445bf2f7bba16d7ec63e114bf916d468cb3d AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:533af462b99ab9a4750899c2217332bb4fb1dfe67cf370ae682d824f857ced76
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
