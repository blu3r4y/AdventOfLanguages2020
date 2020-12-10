// Advent of Code 2020, Day 9
// (c) blu3r4y

open System

let PREAMBLE = 25

let load(path: string) : int64[] =
    // we may see very large numbers and need a long type
    System.IO.File.ReadAllLines(path)
    |> Array.map int64

let windowSums(numbers: int64[], index: int) :Set<int64> =
    // a set with all possible sums of two distinct values,
    // previous of the current index, up to length of the preamble
    let window = numbers.[index - PREAMBLE..index - 1]
    Array.allPairs window window
    |> Array.filter (fun (i, j) -> i <> j)
    |> Array.map (fun (i, j) -> i + j)
    |> Set.ofArray

let rec walk(numbers: int64[], index: int, windows: List<Set<int64>>) :int64=
    let num = numbers.[index]

    // check if there is no match in all the sums of the preamble for this index
    let isValid =
        [ for w in windows -> w.Contains(num) ]
        |> List.contains true

    // drop the oldest window, take the rest, advance and add a new window
    let newIndex = index + 1
    let newWindows =
        (windows |> List.skip 1 |> List.take (PREAMBLE - 1))
        @ [windowSums(numbers, newIndex)]

    // recurse on or return if the number is not valid anymore
    match isValid with
     | true -> walk(numbers, newIndex, newWindows)
     | false -> num

let part1(numbers: int64[]) :int64=
    // fill the window list with the preamble indexes and walk on
    let preambleWindows : List<Set<int64>> =
        [ for i in [0..PREAMBLE - 1] -> windowSums(numbers, i) ]
    walk(numbers, PREAMBLE, preambleWindows)

let part2(numbers: int64[]) :int64 =
    let invalid = part1 numbers

    // just brute-force contiguous ranges
    let rec innerLoop(i: int, j: int, sum: int64): Option<int64> =
        let newSum = sum + numbers.[j]
        match newSum with
         | (x) when x > invalid -> None
         | (x) when x = invalid ->
            let window = numbers.[i..j]
            let result = Array.max window + Array.min window
            Some result
         | _ -> innerLoop(i, j + 1, newSum)

    let rec bruteForce(i: int): int64 =
        // initialize sum with the current value and recurse on
        match innerLoop(i, i + 1, numbers.[i]) with
         | None -> bruteForce(i+1)
         | Some v -> v

    bruteForce(0)

let main(_) =
    let numbers = load "./data/day9.txt"

    Console.WriteLine (part1 numbers)
    Console.WriteLine (part2 numbers)

main()
