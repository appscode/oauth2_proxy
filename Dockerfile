# build stage
FROM golang:1.11-stretch AS build-env
RUN curl -fsSL -o /usr/local/bin/dep https://github.com/golang/dep/releases/download/v0.5.0/dep-linux-amd64 && chmod +x /usr/local/bin/dep
ADD . /go/src/github.com/bitly/oauth2_proxy
WORKDIR /go/src/github.com/bitly/oauth2_proxy
RUN dep ensure -vendor-only && CGO_ENABLED=0 go build -o goapp && chmod +x goapp

# final stage
FROM busybox
COPY --from=build-env /go/src/github.com/bitly/oauth2_proxy/goapp /bin/oauth2_proxy
ENTRYPOINT ["oauth2_proxy"]
