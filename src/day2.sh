#!/bin/bash

# Advent of Code 2020, Day 2
# (c) blu3r4y

# path to input file
INPUT="./assets/day2.txt"

# number of valid passwords for part 1 and 2
NVALID_ONE=0
NVALID_TWO=0

# read the file line by line
while IFS= read -r line
do
    _IFS="$IFS"

    # replace the field delimiters with '#'
    line=${line//: /#}
    line=${line// /#}
    line=${line//-/#}

    # parse to an array named policy
    IFS="#" read -ra policy <<< "$line"

    # extract individual policy parts
    low="${policy[0]}"
    high="${policy[1]}"
    char="${policy[2]}"
    pass="${policy[3]}"

    # count number of requested character
    # (by replacing all others and getting the length)
    cleaned="${pass//[^${char}]}"
    nchars="${#cleaned}"

    # condition for part 1
    if [[ $low -le $nchars ]] && [[ $nchars -le $high ]]
    then NVALID_ONE=$[$NVALID_ONE + 1]; fi

    lbracket=0
    if [[ ${pass:$[low-1]:1} == $char ]]
    then lbracket=1; fi

    hbracket=0
    if [[ ${pass:$[high-1]:1} == $char ]]
    then hbracket=1; fi

    # condition for part 2 (with not-equal instead of xor)
    if [[ $lbracket -ne $hbracket ]]
    then NVALID_TWO=$[$NVALID_TWO + 1]; fi

    IFS="$_IFS"
done < "$INPUT"

echo " $NVALID_ONE "
echo " $NVALID_TWO "
