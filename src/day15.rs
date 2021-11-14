// Advent of Code 2020, Day 15
// (c) blu3r4y

use std::collections::{HashMap, HashSet};
use std::fs;

const INPUT_PATH: &str = "./data/day15.txt";

fn part1(numbers: &Vec<i32>) -> i32 {
    solve(numbers, 2020)
}

fn part2(numbers: &Vec<i32>) -> i32 {
    solve(numbers, 30_000_000)
}

fn solve(numbers: &Vec<i32>, end: usize) -> i32 {
    // store previously seen (everything except last) numbers in a fast set
    let mut seen: HashSet<i32> = numbers.split_last().unwrap().1.iter().copied().collect();

    // store the indexes of previously seen numbers in a fast dict
    let mut index: HashMap<i32, i32> = HashMap::new();
    let mut indexpre: HashMap<i32, i32> = HashMap::new();
    for (i, &val) in numbers.iter().enumerate() {
        index.insert(val, i as i32);
    }

    let mut pre: i32 = *numbers.last().unwrap();
    let mut prepre: i32 = pre;

    for turn in numbers.len()..end {
        // difference or zero
        if seen.contains(&pre) {
            pre = index[&pre] - indexpre[&pre]
        } else {
            pre = 0;
        }

        // append number to history (with a lag of 1)
        seen.insert(prepre);
        prepre = pre;

        // carry over the lag 1 index of that
        if let Some(&old_index) = index.get(&pre) {
            indexpre.insert(pre, old_index);
        }

        // store the index of this number
        index.insert(pre, turn as i32);
    }

    pre
}

fn main() {
    let numbers = load();
    println!("{}", part1(&numbers));
    println!("{}", part2(&numbers));
}

fn load() -> Vec<i32> {
    let lines = fs::read_to_string(INPUT_PATH).unwrap();
    let vec: Vec<i32> = lines
        .trim()
        .split(",")
        .map(|x| x.parse().unwrap())
        .collect();

    vec
}
