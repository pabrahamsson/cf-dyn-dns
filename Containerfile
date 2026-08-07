
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:c2c7b0e204a331eb392a60cc1fcdeade8cf881f682f8370e5668c5c70d723328 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:a4e512a621c761d9fa98d097e1b7c0ccf5027f6f792274629638b61f72aa426e
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
