FROM golang:latest AS builder

WORKDIR /build

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN make all

FROM debian:bookworm-slim

COPY --from=builder /build/alerts_exporter /usr/local/bin/alerts_exporter

ENTRYPOINT [ "alerts_exporter" ]
