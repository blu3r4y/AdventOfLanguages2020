FROM postgres:13

RUN apt-get update && apt-get install -y dos2unix \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home

COPY data/day4.txt data/
COPY src/day4.sql /docker-entrypoint-initdb.d/

# ensure that we have LF line endings
RUN dos2unix data/day4.txt

ENV POSTGRES_PASSWORD=postgres
