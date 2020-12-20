# Advent of Code 2020, Day 11
# (c) blu3r4y

import options
import sequtils

type TextGrid = object
    arr: seq[seq[char]]
    ncols: int
    nrows: int

func newTextGrid(arr: seq[seq[char]]): TextGrid =
    result.arr = arr
    result.ncols = len(arr[0])
    result.nrows = len(arr)

func orient(i: int): tuple[dc: int, dr: int] =
    ## returns the orientation offset by index.
    ## this just a static result for `product([-1, 0, +1], repeat=2)[i]`
    const orients = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
    return orients[i]

iterator coords(grid: TextGrid): tuple[c: int, r: int] =
    ## return all coordinate pairs `(c, r)` in the grid
    for c in 0 ..< grid.ncols:
        for r in 0 ..< grid.nrows:
            yield (c, r)

func set(grid: var TextGrid, c: int, r: int, value: char) =
    ## set the character `value` at column `c` and row `r`
    grid.arr[r][c] = value

func get(grid: TextGrid, c: int, r: int): char =
    ## retrieve the character at column `c` and row `r`
    return grid.arr[r][c]

func count(grid: TextGrid, value: char): int =
    ## return the number of occurrences of the character `value` in the grid
    let counts = grid.arr.mapIt(count(it, value))
    return counts.foldl(a + b)

iterator trace(grid: TextGrid, c: int, r: int, o: int, limit: int = 1): char =
    ## retrieve all the field values in the grid, starting at position `(c, r)`
    ## going into direction `o` for all lengths `1 .. limit` (inclusive)
    let (dc, dr) = orient(o)
    for d in 1 .. limit:
        let tc = c + dc * d
        let tr = r + dr * d
        if 0 <= tc and tc < grid.ncols and 0 <= tr and tr < grid.nrows:
            yield grid.get(tc, tr)

iterator neighbors(grid: TextGrid, c: int, r: int, match: Option[string] = none(string)): char =
    ## retrieve the values of all neighbouring cells, and possibly
    ## filtered only on cell values that match the passed `match` character
    for o in 0 ..< 8:
        for tr in grid.trace(c, r, o):
            if match.isNone or match.get().contains(tr):
                yield tr

func tracesplit(grid: TextGrid, c: int, r: int, o: int, limit: int, match: string): tuple[a: seq[char], b: seq[char]] =
    ## like `trace(c, r, o, limit, match)` but splits the sequence into two parts.
    ## the split occurs once the first element matches the field values
    var a = newSeq[char]()
    var b = newSeq[char]()

    var takewhile = true
    for tr in grid.trace(c, r, o, limit):
        # take everything into sequence a, as long as the cell values do not match
        takewhile = takewhile and not match.contains(tr)

        if takewhile:
            a.add(tr)
        else:
            b.add(tr)

    return (a, b)

iterator starsplit(grid: TextGrid, c: int, r: int, match: string): tuple[a: seq[char], b: seq[char]] =
    ## applies the tracesplit into all 8 directions
    let limit = max(grid.ncols, grid.nrows)
    for o in 0 ..< 8:
        yield grid.tracesplit(c, r, o, limit, match)

###############################################################################

func part1(grid: var TextGrid): int =
    var changeset = @[(0, 0, '0')]

    while len(changeset) > 0:
        changeset.setLen(0)

        for (c, r) in grid.coords():
            let val = grid.get(c, r)

            # number of occupied neighbouring seats
            let numNeighbors = len(toSeq(grid.neighbors(c, r, some("#"))))

            if val == 'L' and numNeighbors == 0:
                changeset.add((c, r, '#'))
            elif val == '#' and numNeighbors >= 4:
                changeset.add((c, r, 'L'))

        for (c, r, val) in changeset:
            grid.set(c, r, val)

    return grid.count('#')

func part2(grid: var TextGrid): int =
    var changeset = @[(0, 0, '0')]

    while len(changeset) > 0:
        changeset.setLen(0)

        for (c, r) in grid.coords():
            let val = grid.get(c, r)
            if val == 'L' or val == '#':

                # number of occupied seats in star-split-sight
                var numOccupied = 0
                for split in grid.starsplit(c, r, "L#"):
                    if len(split.b) > 0 and split.b[0] == '#':
                        numOccupied += 1

                if val == 'L' and numOccupied == 0:
                    changeset.add((c, r, '#'))
                elif val == '#' and numOccupied >= 5:
                    changeset.add((c, r, 'L'))

        for (c, r, val) in changeset:
            grid.set(c, r, val)

    return grid.count('#')

###############################################################################

when is_main_module:
    var text = toSeq(lines("./data/day11.txt")).mapIt(toSeq(it))

    var grid1 = newTextGrid(text)
    echo part1(grid1)

    var grid2 = newTextGrid(text)
    echo part2(grid2)
