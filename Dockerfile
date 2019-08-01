FROM golang:1.11 as builder

RUN mkdir /build

ADD . /build/

WORKDIR /build

ENV GOOS=linux GARCH=amd64 CGO_ENABLED=0

RUN go build -mod vendor -o main .

FROM alpine:3.7

#RUN adduser -S -D -H -h /app appuser

#USER appuser

COPY --from=builder /build/main /app/main

WORKDIR /app

CMD [ "./main" ]
