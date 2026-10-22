
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:e6e12881dc22c4d3420521680b7846c04a1eb97d879b255510b947ee1d3105ba AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:329ff8f46fe69f036b96c3463272aa778a6df6a4f7570f080fd248a414652b6e
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
