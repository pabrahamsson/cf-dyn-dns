
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:d892910a8a82bdd4632e1ca69f00cab20fc2ffa9966bdd7619b22e6e1786e133 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:82ab1238082f405e19e1cc6e4950549371b6742ba6b649ca356c058249162540
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
