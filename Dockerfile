FROM golang:1.15 as builder

RUN mkdir -p /app
WORKDIR /app

COPY go.mod .

ENV GOPROXY https://proxy.golang.org,direct

RUN go mod download

COPY ./hello.go .

ENV CGO_ENABLED=0

RUN GOOS=linux go build ./hello.go

FROM scratch

WORKDIR /app

COPY --from=builder /app/hello .

CMD ["/app/hello"]