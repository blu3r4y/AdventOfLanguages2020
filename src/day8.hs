-- Advent of Code 2020, Day 8
-- (c) blu3r4y

{-# LANGUAGE NamedFieldPuns #-}

import Control.Lens (element, (&), (.~))
import Data.List.Split (splitOn)
import Data.List.Utils (replace)

-- represents an opcode with an offset value
data Instr = Instr {name :: String, value :: Int}

type Code = [Instr]

-- represents the values of all registers in the machine
data Memory = Memory {acc :: Int, ip :: Int, history :: [Int]}

-- represents the current executation state
data State = Running | EndOfCode | InfiniteLoop deriving (Enum, Eq)

-- PART 1: execute until the program terminates
part1 :: Code -> Int
part1 code =
  acc $ fst $ runMachine memory code
  where
    memory = Memory {acc = 0, ip = 0, history = []}

-- PART 2: execute until the program does not end up in an infite loop anymore
part2 :: Code -> Int
part2 code =
  acc $ swapAndRunMachine code 0

-- continue to swap instructions at the specific index until the run is successful
swapAndRunMachine :: Code -> Int -> Memory
swapAndRunMachine code swapIndex =
  if state == InfiniteLoop
    then swapAndRunMachine code (swapIndex + 1)
    else newMemory
  where
    memory = Memory {acc = 0, ip = 0, history = []}
    theRun = runMachine memory (swapInstr code swapIndex)
    newMemory = fst theRun
    state = snd theRun

-- run the machine by executing instruction after instruction
runMachine :: Memory -> Code -> (Memory, State)
runMachine memory code =
  if state /= Running
    then (memory, state)
    else runMachine newMemory code
  where
    state = checkState memory code
    newMemory = execInstr memory (code !! ip memory)

-- interprets a given instruction that changes the state
execInstr :: Memory -> Instr -> Memory
execInstr memory Instr {name = "acc", value} =
  Memory {acc = acc memory + value, ip = ip memory + 1, history = history memory ++ [ip memory]}
execInstr memory Instr {name = "jmp", value} =
  Memory {acc = acc memory, ip = ip memory + value, history = history memory ++ [ip memory]}
execInstr memory Instr {name = "nop"} =
  Memory {acc = acc memory, ip = ip memory + 1, history = history memory ++ [ip memory]}

-- swap nop and jmp instructions at a specific index
swapInstr :: Code -> Int -> Code
swapInstr code index
  | name instr == "jmp" = code & element index .~ Instr {name = "nop", value = value instr}
  | name instr == "nop" = code & element index .~ Instr {name = "jmp", value = value instr}
  | otherwise = code
  where
    instr = code !! index

-- checks if the program terminated by reaching the last instruction
-- or tried to re-execute an instruction, or is still running
checkState :: Memory -> Code -> State
checkState Memory {ip, history} code
  | ip == length code = EndOfCode
  | ip `elem` history = InfiniteLoop
  | otherwise = Running

-- read and parse each line as an instruction
parseFile :: FilePath -> IO Code
parseFile path = map parseInstr . lines <$> readFile path

parseInstr :: String -> Instr
parseInstr line =
  let [name, value] = splitOn " " line
   in Instr {name = name, value = read (replace "+" "" value) :: Int}

main :: IO ()
main = do
  parseFile "./data/day8.txt" >>= print . part1
  parseFile "./data/day8.txt" >>= print . part2
