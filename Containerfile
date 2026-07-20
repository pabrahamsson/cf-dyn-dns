
# Build the manager binary
FROM quay.io/hummingbird/go:latest-builder@sha256:ed2ffa394ca0313b8c59b87efb9b08ded60de40b8f94d75635092349713fa1ca AS builder

# Copy the code
COPY . /src
WORKDIR /src

RUN go build -o /cf-dyn-dns

FROM quay.io/hummingbird/core-runtime:2@sha256:b437b9e46e5f43372fcbf53fab38242ef68638f0f57cd846d243f958cfbc029f
COPY --from=builder /cf-dyn-dns /cf-dyn-dns
ENTRYPOINT ["/cf-dyn-dns"]
