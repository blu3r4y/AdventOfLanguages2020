FROM mtmiller/octave:7.0.0

RUN apt-get update && apt-get install -y dos2unix \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home

COPY data/day6.txt data/
COPY src/day6.m src/

# ensure that we have LF line endings
RUN dos2unix data/day6.txt

WORKDIR /home/src

CMD ["octave", "day6.m"]
