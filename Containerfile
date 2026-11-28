
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:e05309707d18faef3294bda773ac33aebceacf80b7e56a41dda74a182edad160 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:fe49c1e94db2743f99ea08d7bec7b7326595130463f76dd32308e6e122361149
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
