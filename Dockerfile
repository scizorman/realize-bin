FROM golang:1.13-alpine AS builder

LABEL maintainer "Tetsutaro Ueda <tueda1207@gmail.com>"

WORKDIR /work

RUN apk add --no-cache \
  git \
  upx

RUN go get -u github.com/pwaller/goupx

RUN go get -u -ldflags="-w -s" github.com/oxequa/realize

RUN upx /go/bin/realize

FROM golang:1.13-alpine

COPY --from=builder /go/bin/realize /usr/local/bin/realize

ENTRYPOINT [ "realize" ]

CMD [ "--help" ]
