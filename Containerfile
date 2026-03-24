
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:54a1de507f1b0bf50ba1e1bc5e355c32b0691ff563863cc239331d8e1c981d4e AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:30761e7f7a4dbcc2257dcf81afa5a6f7e5ae0f69c3d13b7773efbd21c5547c5c
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
