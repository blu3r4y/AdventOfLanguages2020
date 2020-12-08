% Advent of Code 2020, Day 5
% (c) blu3r4y

:- initialization main, halt.

% read the file, map the lines to seat ids, and compute the result
main() :-
  read_input('./data/day5.txt', Input),
  maplist(seat_id, Input, SeatIds),

  part_one(SeatIds, ResultPart1),
  part_two(SeatIds, ResultPart2),

  write(ResultPart1), nl,
  write(ResultPart2).

% read the file into a list of strings
read_input(FilePath, Input) :-
  read_file_to_string(FilePath, String, []),
  split_string(String, '\n', '\n', Input).

% PART 1: maximum of seat ids
part_one(SeatIds, Result) :-
  max_list(SeatIds, Result).

% PART 2: the missing spot in all those ids
part_two(SeatIds, Result) :-
  sort(SeatIds, SortedIds),
  free_spot(SortedIds, Result).

% get the first value of the list item that is non-consecutive
free_spot(List, FreeSpot) :-
  length(List, Length),
  between(1, Length, Index1),

  Index2 is Index1 + 1,
  nth1(Index1, List, Ele1),
  nth1(Index2, List, Ele2),

  Ele2 - Ele1 =\= 1,
  FreeSpot is Ele1 + 1.

% compute the seat id by transcoding the row and col parts
seat_id(String, Result) :-
  sub_string(String, 0, 7, _, RowStr),
  sub_string(String, 7, 3, _, ColStr),
  string_chars(RowStr, RowArr),
  string_chars(ColStr, ColArr),

  transcode(RowArr, RowResult),
  transcode(ColArr, ColResult),

  Result is RowResult * 8 + ColResult.

% transcode a list of characters to their numeric value
transcode(Code, Result) :-
  length(Code, Length),
  transcodeRec(Code, Length, 0, Result).

transcodeRec(_, 0, Result, Result) :- !.
transcodeRec(Code, Pos, Sum, Result) :-
  [Head|CodeRest] = Code,

  bit(Head, BitVal),
  PosNext is Pos - 1,

  SumNext is Sum + BitVal * (2 ^ PosNext),

  transcodeRec(CodeRest, PosNext, SumNext, Result).

% only 'B' and 'R' represent a binary 1 in the code
bit(Char, Val) :- Char = 'B', Val = 1.
bit(Char, Val) :- Char = 'R', Val = 1.
bit(_, Val) :- Val = 0.
