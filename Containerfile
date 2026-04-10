
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:e0215c751b043585fb6e3838079f6ab64f381dccf927a2a6e77fe6e97722b944 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:70e170d73aa5f01abc29312badbd70f614288c3a5925e605855cdf88806b9a1d
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
