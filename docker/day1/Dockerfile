FROM alpine:3

RUN apk add --no-cache alpine-sdk

WORKDIR /home

COPY docker/day1/Makefile build/
COPY data/day1.txt data/
COPY src/day1.s src/

RUN cd build && make

CMD [ "/home/build/day1" ]
