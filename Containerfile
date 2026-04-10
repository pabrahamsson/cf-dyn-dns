
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:ce97a68301f6f5362c2eeeb4f0ea7989e95991bec75ff5b2fc9b38cb94dcf9f2 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:70e170d73aa5f01abc29312badbd70f614288c3a5925e605855cdf88806b9a1d
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
