
FROM golang:alpine as builder

RUN apk update && apk add git 
COPY . $GOPATH/src/dsmith73/openweathermap_exporter/
WORKDIR $GOPATH/src/dsmith73/openweathermap_exporter/
RUN go get -d -v


RUN go build -o /go/bin/openweathermap_exporter


FROM alpine
EXPOSE 2112
COPY --from=builder /go/bin/openweathermap_exporter /bin/openweathermap_exporter
ENTRYPOINT ["/bin/openweathermap_exporter"]

# Environment Variables
# OWM_PORT  
# OWM_API_KEY  
# OWM_LOCATION  
# OWM_DURATION  
