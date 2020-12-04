-- Advent of Code 2020, Day 4
-- (c) blu3r4y

-- this will hold our final result
DROP TABLE IF EXISTS solution;
CREATE TABLE solution (
    part INTEGER UNIQUE NOT NULL,
    solution INTEGER NOT NULL
);

-- read the file by putting each line into a single row
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (
    line_number SERIAL PRIMARY KEY,
    line TEXT
);

COPY raw (line) FROM '/home/data/day4.txt';

-- use this table for the final, parsed input
DROP TABLE IF EXISTS input;
CREATE TABLE input (
    line TEXT
);

-- assign part numbers by counting the number of empty lines
-- with a window filter and grouping by that later on
INSERT INTO input
SELECT STRING_AGG(line, ' ') AS line FROM (
    SELECT
        line,
        COUNT(*) FILTER (WHERE line = '')
        OVER (ORDER BY line_number) AS part
    FROM raw
    ) AS parts
GROUP BY parts.part;

------------
-- PART 1 --
------------

INSERT INTO solution
SELECT
    1 AS part,
    COUNT(*) AS solution
FROM (
    -- sum how many of the raw lines contain how many of our desired keys
    SELECT
        ((line LIKE '%byr:%')::INTEGER +
        (line LIKE '%iyr:%')::INTEGER +
        (line LIKE '%eyr:%')::INTEGER +
        (line LIKE '%hgt:%')::INTEGER +
        (line LIKE '%hcl:%')::INTEGER +
        (line LIKE '%ecl:%')::INTEGER +
        (line LIKE '%pid:%')::INTEGER) AS num_fields
    FROM input
) AS counts
WHERE counts.num_fields = 7;

------------
-- PART 2 --
------------

DROP TABLE IF EXISTS passports;
CREATE TABLE passports (
    byr INTEGER,
    iyr INTEGER,
    eyr INTEGER,
    hgt INTEGER,
    hgt_unit VARCHAR(2),
    hcl VARCHAR(7),
    ecl VARCHAR(3),
    pid INTEGER
);

INSERT INTO passports
SELECT
    substring(line from 'byr:(\d{4})\M')::INTEGER AS byr,
    substring(line from 'iyr:(\d{4})\M')::INTEGER AS iyr,
    substring(line from 'eyr:(\d{4})\M')::INTEGER AS eyr,
    substring(line from 'hgt:(\d+)(cm|in)\M')::INTEGER AS hgt,
    substring(line from 'hgt:\d+(cm|in)\M') AS hgt_unit,
    substring(line from 'hcl:(#[0-9a-f]{6})\M') AS hcl,
    substring(line from 'ecl:(amb|blu|brn|gry|grn|hzl|oth)\M') AS ecl,
    substring(line from 'pid:(\d{9})\M')::INTEGER AS pid
FROM input;

INSERT INTO solution
SELECT
    2 AS part,
    COUNT(*) AS solution
FROM passports
WHERE
    byr IS NOT NULL AND
    iyr IS NOT NULL AND
    eyr IS NOT NULL AND
    hgt IS NOT NULL AND
    hcl IS NOT NULL AND
    ecl IS NOT NULL AND
    pid IS NOT NULL AND
    1920 <= byr AND byr <= 2002 AND
    2010 <= iyr AND iyr <= 2020 AND
    2020 <= eyr AND eyr <= 2030 AND
    ((hgt_unit = 'cm' AND 150 <= hgt AND hgt <= 193) OR
        (hgt_unit = 'in' AND 59 <= hgt AND hgt <= 76));


-- print final result
SELECT * FROM solution;
