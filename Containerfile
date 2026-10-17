
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:e6e12881dc22c4d3420521680b7846c04a1eb97d879b255510b947ee1d3105ba AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:cefdad691990bab9d5371070824c1bb52b9a0a9733eaf543eded2a6964715881
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
