FROM golang:1.17-alpine

RUN apk add --no-cache alpine-sdk

WORKDIR /home

COPY docker/day14/Makefile bin/
COPY data/day14.txt data/
COPY src/day14.go src/

# ensure that we have LF line endings
RUN dos2unix bin/Makefile

RUN cd bin && make

CMD [ "/home/bin/day14" ]
