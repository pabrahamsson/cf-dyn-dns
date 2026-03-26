
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:58ab27718af699ee06e6638fb09ffd497b0a407e492981f875cd6adc63f6649b AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:30761e7f7a4dbcc2257dcf81afa5a6f7e5ae0f69c3d13b7773efbd21c5547c5c
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
