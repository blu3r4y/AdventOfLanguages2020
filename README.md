# Advent of Languages 2020

💔 🖤 💛 🧡 💜 💙 💚 ❤️

Solutions for the [AoC 2020](https://adventofcode.com/2020) puzzles, written in 25 different programming languages.

- 💔 **Assembly** Languages
- 🖤 **Shell Scripting** Languages
- 💛 **Database** Languages
- 🧡 **Mathematical** Languages
- 💜 **Functional** Languages
- 💙 **System Programming** Languages
- 💚 **Web Application** Languages
- ❤️ **General-Purpose** Languages

## Solutions

| Day | Puzzle | Language | Reference | Solution |
| --: | :----- | :------- | :-------- | :------- |
| 1 | [Report Repair](https://adventofcode.com/2020/day/1) | 💔 x86-32 | [day1.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day1.py) | <img width="16" src="./images/file_type_assembly.svg" />&nbsp; **[day1.s](src/day1.s)** |
| 2 | [Password Philosophy](https://adventofcode.com/2020/day/2) | 🖤 Bash | [day2.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day2.py) | <img width="16" src="./images/file_type_shell.svg" />&nbsp; **[day2.sh](src/day2.sh)** |
| 3 | [Toboggan Trajectory](https://adventofcode.com/2020/day/3) | 🖤 PowerShell | [day3.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day3.py) | <img width="16" src="./images/file_type_powershell.svg" />&nbsp; **[day3.ps1](src/day3.ps1)** |
| 4 | [Passport Processing](https://adventofcode.com/2020/day/4) | 💛 PostgreSQL | [day4.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day4.py) | <img width="16" src="./images/file_type_sql.svg" />&nbsp; **[day4.sql](src/day4.sql)** |
| 5 | [Binary Boarding](https://adventofcode.com/2020/day/5) | 🧡 Prolog | [day5.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day5.py) | <img width="16" src="./images/file_type_prolog.svg" />&nbsp; **[day5.pl](src/day5.pl)** |
| 6 | [Custom Customs](https://adventofcode.com/2020/day/6) | 🧡 Octave | [day6.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day6.py) | <img width="16" src="./images/file_type_matlab.svg" />&nbsp; **[day6.m](src/day6.m)** |
| 7 | [Handy Haversacks](https://adventofcode.com/2020/day/7) | 🧡 R | [day7.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day7.py) | <img width="16" src="./images/file_type_r.svg" />&nbsp; **[day7.R](src/day7.R)** |
| 8 | [Handheld Halting](https://adventofcode.com/2020/day/8) | 💜 Haskell | [day8.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day8.py) | <img width="16" src="./images/file_type_haskell.svg" />&nbsp; **[day8.hs](src/day8.hs)** |
| 9 | [Encoding Error](https://adventofcode.com/2020/day/9) | 💜 F# | [day9.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day9.py) | <img width="16" src="./images/file_type_fsharp.svg" />&nbsp; **[day9.fsx](src/day9.fsx)** |
| 10 | [Adapter Array](https://adventofcode.com/2020/day/10) | 💜 Scala | [day10.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day10.py) | <img width="16" src="./images/file_type_scala.svg" />&nbsp; **[day10.scala](src/day10.scala)** |
| 11 | [Seating System](https://adventofcode.com/2020/day/11) | 💙 Nim | [day11.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day11.py) | <img width="16" src="./images/file_type_light_nim.svg" />&nbsp; **[day11.nim](src/day11.nim)** |
| 12 | [Rain Risk](https://adventofcode.com/2020/day/12) | 💙 C | [day12.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day12.py) | <img width="16" src="./images/file_type_c.svg" />&nbsp; **[day12.c](src/day12.c)** |
| 13 | [Shuttle Search](https://adventofcode.com/2020/day/13) | 💙 C++ | [day13.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day13.py) | <img width="16" src="./images/file_type_cpp.svg" />&nbsp; **[day13.cpp](src/day13.cpp)** |
| 14 | [Docking Data](https://adventofcode.com/2020/day/14) | 💙 Go | [day14.py](https://github.com/blu3r4y/AdventOfCode2020/blob/main/src/day14.py) | <img width="16" src="./images/file_type_go.svg" />&nbsp; **[day14.go](src/day14.go)** |

## Usage

Instead of installing 25 toolchains, simply run each solution with Docker

    export DAY=1
    docker build -f ./docker/day${DAY}/Dockerfile -t day${DAY} .
    docker run --rm -it day${DAY}

Input files must have LF line endings, which should be the default on checkout, if not, fix that with

    dos2unix data/*.txt

## License

Solutions are licensed under [MIT](./LICENSE.txt).
File icons are licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) and authored by [vscode-icons](https://github.com/vscode-icons/vscode-icons).

## Comments

This section holds a brief description on how I experienced each day.

#### 💔 x86-32

I guess I can't blame Assembly for not being user-friendly, right?
Parsing a simple list of numbers was a nightmare.
Printing them, even more.
And I hope nobody sees that I abused stack pointers for my loop counters.
Apart from that, I am really glad that my solution fits into a 32 bit register.
I wouldn't have known what to do if it didn't.

#### 🖤 Bash

I hated this.
A language where `x=1` is not the same as `x = 1` should not exist in this world.
And what special magic is `$IFS` after all?
And when do I use single brackets, double brackets, braces or some other magic for my conditionals?
Very inconsistent and ugly.
Will chose Assembly over Bash next time.

#### 🖤 PowerShell

Although I hated to use `-eq` for simple comparisons, this looks much nicer than I initially expected.
Can we please stop writing Bash scripts and use PowerShell from now on?
It's also really cool that one can call .NET library functions from PowerShell.

#### 💛 PostgreSQL

Parsing a file into a table was the only challenge here.
I am glad that I found this window function magic.
The rest was easy.
Oh, and I briefly looked into the Perl scripting mode for parsing stuff.
However, I am so embarrassed by Perl that I don't even dare to commit that part.

#### 🧡 Prolog

Just declaring the conditions to find the non-consecutive item in a list - in a mathematical way - and having Prolog figuring out how to solve that was a marvelous experience.
Would code again.

#### 🧡 Octave

While I didn't like the syntax, the standard library provided enough functions to write this in a very clean way.

#### 🧡 R

I hated to have lists, arrays and all this inconsistent indexing magic.
Plus, I know that loops are slow, but, if the language doesn't give me a nice interface to write this in a functional way, what do you expect me to do?

#### 💜 Haskell

Very consistent and mighty once you get used to all the special characters in the syntax.
However, it's a pity that you are forced to write everything in a functional way.
This isn't the best way of thinking for every problem.

#### 💜 F#

If I would just have written normal loops instead of a recursive solution, I would have written a recursive solution instead of normal loops.

#### 💜 Scala

It feels very natural that one can write function chains from left to right.
Although, I think the standard library has much less functions compared to Haskell.
For one, missed `itertools.groupby` from Python here.

#### 💙 Nim

This took some time to write, but it was worth it.
It is fantastic to have code that is as readable as Python but compiles to fast machine code at the end of the day.
Sadly, the compiler messages weren't very helpful when learning Nim and the documentation could be better.
And I hate macro magic.
Nevertheless, a great language.

#### 💙 C

Parsing the input was the only real challenge here, once again.
Apart from that, well, it's just C.

#### 💙 C++

Thanks to `__int128` for saving my algorithm.
Plus, I learned that `a % b` returns different results in Python and C++.
I was missing list comprehensions and tuple unpacking a lot here.
And that there is no `argmax()` or `enumerate()`.
And I hated that there is no `.split(",")` function to parse comma-separated lists easily.
I probably code too much Python.

#### 💙 Go

Good experience overall, I liked it.
Go has a very well-designed standard library with plenty of utility functions.
Only the syntax when appending to slices seemed a bit odd at first.
