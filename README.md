# Advent of Languages 2020

Solutions for the [AoC 2020](https://adventofcode.com/2020) puzzles, written in 25 different programming languages.

:christmas_tree: :christmas_tree: :christmas_tree:

### Categories

- 💔 **Assembly** Languages
- 🖤 **Shell Scripting** Languages
- 💛 **Database** Languages
- 🧡 **Mathematical** Languages
- 💜 **Functional** Languages
- 💙 **System Programming** Languages
- 💚 **Web Application** Languages
- ❤️ **General-Purpose** Languages

### Solutions

| Day | Puzzle | Language | Reference | Solution |
| --: | :----- | :------- | :-------- | :------- |
| 1 | [Report Repair](https://adventofcode.com/2020/day/1) | 💔 x86-32 | [day1.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day1.py) | **[day1.s](src/day1.s)** |
| 2 | [Password Philosophy](https://adventofcode.com/2020/day/2) | 🖤 Bash | [day2.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day2.py) | **[day2.sh](src/day2.sh)** |
| 3 | [Toboggan Trajectory](https://adventofcode.com/2020/day/3) | 🖤 PowerShell | [day3.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day3.py) | **[day3.ps1](src/day3.ps1)** |
| 4 | [Passport Processing](https://adventofcode.com/2020/day/4) | 💛 PostgreSQL | [day4.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day4.py) | **[day4.sql](src/day4.sql)** |
| 5 | [Binary Boarding](https://adventofcode.com/2020/day/5) | 🧡 Prolog | [day5.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day5.py) | **[day5.pl](src/day5.pl)** |
| 6 | [Custom Customs](https://adventofcode.com/2020/day/6) | 🧡 Octave | [day6.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day6.py) | **[day6.m](src/day6.m)** |

### Usage

Instead of installing 25 toolchains, simply run each solution with Docker

    export DAY=1
    docker build -f ./docker/day${DAY}/Dockerfile -t day${DAY} .
    docker run --rm -it day${DAY}
