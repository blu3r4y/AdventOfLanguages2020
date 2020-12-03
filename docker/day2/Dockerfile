FROM bash:5

WORKDIR /home

COPY data/day2.txt data/
COPY src/day2.sh src/

# ensure that we have LF line endings
RUN dos2unix data/day2.txt && \
    dos2unix src/day2.sh

CMD [ "bash", "/home/src/day2.sh" ]
