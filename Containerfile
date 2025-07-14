
# Build the manager binary
FROM registry.access.redhat.com/ubi10/go-toolset:10.0-1751903775@sha256:050c556adbf8a684de705abadfdfaf105936e5b4e7abe4f46d6b095a684bfa37 AS builder
ARG TARGETOS=linux
ARG TARGETARCH=amd64
ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

# Copy the code
WORKDIR /opt/app-root/src
COPY . .

RUN export CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH} && \
  go build -buildvcs=false . 
RUN ls -al

FROM registry.access.redhat.com/ubi10/ubi-micro:10.0-1752503284@sha256:9593c03e87d283c884522ad3e2ca98aab43a4b63162a82bfd369f6d62402883b

ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

ENV GOTRACEBACK=all

WORKDIR /

COPY --from=builder /opt/app-root/src/cf-dyn-dns /cf-dyn-dns

USER 1001
ENTRYPOINT ["/cf-dyn-dns"]
