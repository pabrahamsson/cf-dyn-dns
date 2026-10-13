
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:c928ea1c9b29e092cb679614a7a0c114f6a614a6c808772d419db5330037d494 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:1abbb3f306dd1df28c46415def816056247cf850b861655097d46af971746f9b
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
