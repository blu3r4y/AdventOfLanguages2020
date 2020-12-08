FROM mtmiller/octave:7.0.0

WORKDIR /home

COPY data/day6.txt data/
COPY src/day6.m src/

WORKDIR /home/src

CMD ["octave", "day6.m"]
