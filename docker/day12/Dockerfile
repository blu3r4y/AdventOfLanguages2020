FROM alpine:3

RUN apk add --no-cache alpine-sdk

WORKDIR /home

COPY docker/day12/Makefile bin/
COPY data/day12.txt data/
COPY src/day12.c src/

# ensure that we have LF line endings
RUN dos2unix bin/Makefile && \
    dos2unix src/day12.c

RUN cd bin && make

CMD [ "/home/bin/day12" ]
