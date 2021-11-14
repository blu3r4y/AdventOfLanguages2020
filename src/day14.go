// Advent of Code 2020, Day 14
// (c) blu3r4y

package main

import (
	"bufio"
	"fmt"
	"log"
	"math"
	"os"
	"strconv"
	"strings"
)

const INPUT_PATH = "./data/day14.txt"
const BIT_LENGTH = 36

type Assignment struct {
	addr uint64
	val  uint64
}

type Masking struct {
	zeros  uint64
	ones   uint64
	floats uint64
}

func main() {
	program := load(INPUT_PATH)
	fmt.Println(part1(program))
	fmt.Println(part2(program))
}

func part1(program []interface{}) uint64 {
	var mask Masking
	memory := make(map[uint64]uint64)

	for _, stmt := range program {
		switch stmt.(type) {
		case Masking:
			// activate new mask
			mask = stmt.(Masking)

		case Assignment:

			// set ones, clear zeros
			var val uint64
			val = stmt.(Assignment).val
			val |= mask.ones
			val &= ^mask.zeros

			memory[stmt.(Assignment).addr] = val
		}
	}

	return sumMapValues(memory)
}

func part2(program []interface{}) uint64 {
	var mask Masking
	memory := make(map[uint64]uint64)

	for _, stmt := range program {
		switch stmt.(type) {
		case Masking:
			// activate new mask
			mask = stmt.(Masking)

		case Assignment:

			// set ones, clear floats
			var addr uint64
			addr = stmt.(Assignment).addr
			addr |= mask.ones
			addr &= ^mask.floats

			// find all indexes of 1s in the original floating mask
			var indexes []int
			for i := 0; i < BIT_LENGTH; i++ {
				if (mask.floats & (1 << i)) != 0 {
					indexes = append(indexes, i)
				}
			}

			// iterate over all possible binary combinations
			numCombinations := int(math.Pow(2.0, float64(len(indexes))))
			for i := 0; i < numCombinations; i++ {
				newAddr := addr
				bitPos := 0

				quo := i
				rem := 0

				for quo > 0 {
					rem = quo % 2
					quo = quo / 2

					if rem == 1 {
						// 0 bits are cleared already at the beginning
						newAddr |= (1 << indexes[bitPos])
					}

					bitPos++
				}

				memory[newAddr] = stmt.(Assignment).val
			}
		}
	}

	return sumMapValues(memory)
}

func load(path string) []interface{} {
	file, err := os.Open(path)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	var program []interface{}

	// extract three bit masks from the mask string
	zrep := strings.NewReplacer("0", "1", "1", "0", "X", "0")
	orep := strings.NewReplacer("0", "0", "1", "1", "X", "0")
	frep := strings.NewReplacer("0", "0", "1", "0", "X", "1")

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()

		if strings.HasPrefix(line, "mask") {
			// 'mask = BITS'
			bits := strings.TrimPrefix(line, "mask = ")

			zeros, _ := strconv.ParseUint(zrep.Replace(bits), 2, 64)
			ones, _ := strconv.ParseUint(orep.Replace(bits), 2, 64)
			floats, _ := strconv.ParseUint(frep.Replace(bits), 2, 64)

			program = append(program, Masking{zeros, ones, floats})
		} else if strings.HasPrefix(line, "mem") {
			// 'mem[ADDR] = VAL'
			parts := strings.Split(strings.TrimPrefix(line, "mem["), "] = ")

			addr, _ := strconv.ParseUint(parts[0], 10, 64)
			val, _ := strconv.ParseUint(parts[1], 10, 64)

			program = append(program, Assignment{addr, val})
		}
	}

	return program
}

func sumMapValues(m map[uint64]uint64) uint64 {
	var result uint64
	for _, val := range m {
		result += val
	}
	return result
}
