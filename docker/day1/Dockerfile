FROM alpine:3

RUN apk add --no-cache alpine-sdk

WORKDIR /home

COPY docker/day1/Makefile build/
COPY data/day1.txt data/
COPY src/day1.s src/

# ensure that we have LF line endings
RUN dos2unix build/Makefile && \
    dos2unix data/day1.txt && \
    dos2unix src/day1.s

RUN cd build && make

CMD [ "/home/build/day1" ]
