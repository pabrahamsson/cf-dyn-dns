
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:c8c5751189dc386b2d9458b73f1b29618b9d86831bf1e147beab2c3989886a16 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:3684aec36bb5cb0ca62ac911578fc9a99f9ad6d397ee69da4cefecedac669688
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
