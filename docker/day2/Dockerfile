FROM alpine:3

RUN apk add --no-cache bash

WORKDIR /home

COPY data/day2.txt data/
COPY src/day2.sh src/

CMD [ "/bin/bash", "/home/src/day2.sh" ]
