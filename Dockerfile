# build stage
FROM golang:alpine AS build-env
ADD . /go/src/github.com/bitly/oauth2_proxy
RUN cd /go/src/github.com/bitly/oauth2_proxy && go build -o goapp

# final stage
FROM alpine
RUN apk add --update --no-cache ca-certificates
COPY --from=build-env  /go/src/github.com/bitly/oauth2_proxy/goapp /bin/oauth2_proxy
RUN chmod +x /bin/oauth2_proxy
ENTRYPOINT ["oauth2_proxy"]
