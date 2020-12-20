FROM nimlang/nim:1.4.2-alpine

RUN apk add --no-cache alpine-sdk

WORKDIR /home

COPY docker/day11/Makefile bin/
COPY data/day11.txt data/
COPY src/day11.nim src/

# ensure that we have LF line endings
RUN dos2unix bin/Makefile

RUN cd bin && make

CMD [ "/home/bin/day11" ]
