
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:95f1cccb2b72fa2c4b2fb382ee2358fe6ab2c69279106886a5d9ef24a792f6a8 AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:08ede4ddf55f824f96a3b55eba02097f66c2c1d9693523bd5e94de59b3359b9e
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
