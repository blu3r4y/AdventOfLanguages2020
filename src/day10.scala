// Advent of Code 2020, Day 10
// (c) blu3r4y

import scala.io.Source

object Day10 {

  val PATH = "/home/data/day10.txt"

  def main(args: Array[String]) = {
    val jolts = load(PATH)
    System.out.println(part1(jolts))
    System.out.println(part2(jolts))
  }

  def load(path: String): List[Int] = {
    var jolts = Source.fromFile(path).getLines.toList.map(_.toInt)
    jolts = 0 :: jolts.max + 3 :: jolts
    jolts.sorted
  }

  def part1(jolts: Seq[Int]): Int = {
    val diffs = diff(jolts)
    diffs.count(_ == 1) * diffs.count(_ == 3)
  }

  def part2(jolts: Seq[Int]): Long = {
    val diffs = diff(jolts)
    val lengths = consecutive(diffs)
    val perms = lengths.map(permutations)
    perms.map(_.toLong).product
  }

  def consecutive(seq: Seq[Int]): Seq[Int] = {
    for (vals <- split(seq) if vals.head == 1)
      yield vals.length
  }

  def permutations(n: Int): Int = {
    if (n < 2) 1 else tribonacci(n + 2)
  }

  def tribonacci(n: Int): Int = {
    n match {
      case 0 => 0
      case 1 => 0
      case 2 => 1
      case _ => tribonacci(n - 1) + tribonacci(n - 2) + tribonacci(n - 3)
    }
  }

  def diff(seq: Seq[Int]): Seq[Int] = {
    (seq.drop(1) zip seq)
      .map(t => t._1 - t._2)
  }

  def split(seq: Seq[Int]): List[List[Int]] = {
    // itertools.groupby in Scala (https://stackoverflow.com/a/4763086/927377)
    seq.foldRight(List[List[Int]]()) { (e, acc) =>
      acc match {
        case (`e` :: xs) :: fs => (e :: e :: xs) :: fs
        case _                 => List(e) :: acc
      }
    }
  }
}
