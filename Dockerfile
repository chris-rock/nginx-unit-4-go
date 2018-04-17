# build
FROM golang:stretch AS build-env
RUN apt-get update
RUN apt-get install -y build-essential
RUN git clone https://github.com/nginx/unit.git /go/src/github.com/nginx/unit
RUN cd /go/src/github.com/nginx/unit && git checkout tags/1.0 && ./configure && ./configure go && make go-install

ADD . /go/src/github.com/chris-rock/nginx-unit-4-go
RUN cd /go/src/github.com/chris-rock/nginx-unit-4-go && go build -o /hello hello.go

# runtime
FROM nginx/unit
COPY --from=build-env /hello /srv/unit/go/hello
ADD unit.json /srv/unit/go/unit.json
RUN unitd && curl -X PUT -d @/srv/unit/go/unit.json --unix-socket ./run/control.unit.sock http://localhost/
CMD ["unitd","--no-daemon"]