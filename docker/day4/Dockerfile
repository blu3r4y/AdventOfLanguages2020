FROM postgres:13

WORKDIR /home

COPY data/day4.txt data/
COPY src/day4.sql /docker-entrypoint-initdb.d/

ENV POSTGRES_PASSWORD=postgres
