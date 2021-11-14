FROM rust:1.56-alpine3.13

RUN apk add --no-cache alpine-sdk

WORKDIR /home

COPY docker/day15/Makefile bin/
COPY data/day15.txt data/
COPY src/day15.rs src/

# ensure that we have LF line endings
RUN dos2unix bin/Makefile

RUN cd bin && make

CMD [ "/home/bin/day15" ]
