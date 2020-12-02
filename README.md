# Advent of Languages 2020

Solutions for the [AoC 2020](https://adventofcode.com/2020) puzzles, written in 25 different programming languages.

:christmas_tree: :christmas_tree: :christmas_tree:

### Categories

- 💔 **Assembly** Languages
- 🖤 **Command-Line** Languages
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

### Usage

Instead of installing 25 toolchains, simply run each solution with Docker

    export DAY=1
    docker build -f ./docker/day${DAY}/Dockerfile -t day${DAY} .
    docker run --rm -it day${DAY}
