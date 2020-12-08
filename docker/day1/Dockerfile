FROM alpine:3

RUN apk add --no-cache alpine-sdk

WORKDIR /home

COPY docker/day1/Makefile bin/
COPY data/day1.txt data/
COPY src/day1.s src/

# ensure that we have LF line endings
RUN dos2unix bin/Makefile && \
    dos2unix src/day1.s

RUN cd bin && make

CMD [ "/home/bin/day1" ]
