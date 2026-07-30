
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:990373bb0947747bc6cd391015f6175c2730bf5ae620d65a8331d93c41757e91 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:974dec56b9fb3d6922ef585ed456d3cc705845002d1b45eeb3bf52314382a740
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
