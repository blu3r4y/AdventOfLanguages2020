FROM swipl:8.2.3

RUN apt-get update && apt-get install -y dos2unix \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home

COPY data/day5.txt data/
COPY src/day5.pl src/

# ensure that we have LF line endings
RUN dos2unix data/day5.txt

CMD ["swipl", "src/day5.pl"]
