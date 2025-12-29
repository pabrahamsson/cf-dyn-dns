
# Build the manager binary
FROM registry.access.redhat.com/ubi10/go-toolset:10.1-1766405849@sha256:4d65503c0066e26df81fbfe93203f0e7dbc23cf503ca2972fef01cdc13cd813c AS builder
ARG TARGETOS=linux
ARG TARGETARCH=amd64
ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

# Copy the code
WORKDIR /opt/app-root/src
COPY . .

RUN export CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH} && \
  go build -buildvcs=false . 
RUN ls -al

FROM registry.access.redhat.com/ubi10/ubi-micro:10.1-1765178423@sha256:d5ba6a075880deb061ac2c7d89c7c409e7948b3abd60b591578621c1b6307b62

ARG MODULE=github.com/pabrahamsson/cf-dyn-dns

ENV GOTRACEBACK=all

WORKDIR /

COPY --from=builder /opt/app-root/src/cf-dyn-dns /cf-dyn-dns

USER 1001
ENTRYPOINT ["/cf-dyn-dns"]
