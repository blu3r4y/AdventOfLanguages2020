# Advent of Code 2020, Day 3
# (c) blu3r4y

$INPUT_PATH = "./data/day3.txt"

function Get-PartOne {
    param ( [char[][]]$Matrix )

    $Result = Get-NumberOfTrees $Matrix 3 1
    Write-Output $Result
}

function Get-PartTwo {
    param ( [char[][]]$Matrix )

    $Result = Get-NumberOfTrees $Matrix 1 1
    $Result *= Get-NumberOfTrees $Matrix 3 1
    $Result *= Get-NumberOfTrees $Matrix 5 1
    $Result *= Get-NumberOfTrees $Matrix 7 1
    $Result *= Get-NumberOfTrees $Matrix 1 2

    Write-Output $Result
}

function Get-NumberOfTrees {
    param ( [char[][]]$Matrix, [int]$SlopeX, [int]$SlopeY )

    $LimitX, $LimitY = $Matrix[0].Length, $Matrix.Length

    $NumTrees = 0
    $X, $Y = 0, 0

    # traverse until we reach the bottom
    while ($Y -lt $LimitY) {
        # retrieve element, but wrap around all axis
        $Element = $Matrix[$Y % $LimitY][$X % $LimitX]
        if ($Element -eq "#") {
            $NumTrees++
        }

        $X = $X + $SlopeX
        $Y = $Y + $SlopeY
    }

    Write-Output $NumTrees
}

# index with [y, x]
$Matrix = Get-Content $INPUT_PATH

Get-PartOne $Matrix
Get-PartTwo $Matrix
