FROM alpine:3

RUN apk add --no-cache alpine-sdk

WORKDIR /home

COPY docker/day13/Makefile bin/
COPY data/day13.txt data/
COPY src/day13.cpp src/

# ensure that we have LF line endings
RUN dos2unix bin/Makefile && \
    dos2unix src/day13.cpp

RUN cd bin && make

CMD [ "/home/bin/day13" ]
