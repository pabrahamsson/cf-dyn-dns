
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:58ab27718af699ee06e6638fb09ffd497b0a407e492981f875cd6adc63f6649b AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:70e170d73aa5f01abc29312badbd70f614288c3a5925e605855cdf88806b9a1d
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
