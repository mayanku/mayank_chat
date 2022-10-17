FROM golang:alpine as build-env

ENV GO111MODULE=on

RUN apk update && apk add bash ca-certificates git gcc g++ libc-dev

RUN mkdir /mayank_chat
RUN mkdir -p /mayank_chat/proto 

WORKDIR /mayank_chat

COPY ./proto/service.pb.go /mayank_chat/proto
COPY ./main.go /mayank_chat

COPY go.mod .
COPY go.sum .

RUN go mod download

RUN go build -o mayank_chat .

CMD ./mayank_chat