
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:3676bcd20d81b6f3497e66bf62f645d5529a97d17f5fed4772fe3b9095da8a2b AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:fe49c1e94db2743f99ea08d7bec7b7326595130463f76dd32308e6e122361149
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
