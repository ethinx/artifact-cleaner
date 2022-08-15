FROM golang:1.18-alpine AS builder
WORKDIR /cleaner
ENV CGO_ENABLED=0
COPY *.go go.mod go.sum ./
RUN go build -ldflags="-s -w"

FROM gcr.io/distroless/static
ENTRYPOINT ["/usr/bin/cleaner"]
COPY --from=builder /cleaner/artifact-cleaner /usr/bin/cleaner
