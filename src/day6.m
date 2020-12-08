# Advent of Code 2020, Day 6
# (c) blu3r4y

function day6
    data = fileread("../data/day6.txt");

    # split by groups, and split groups by individuals then
    groups = strsplit(data, "\n\n");
    indiv = cellfun(@(grp) strsplit(grp, "\n"), groups, 'UniformOutput', false);

    disp(part1(indiv));
    disp(part2(indiv));
endfunction

# PART 1: summarize the number of unique characters in each group
function result = part1(indiv)
    result = sum(cellfun(@(grp) length(unique(strcat(grp{:}))), indiv));
endfunction

# PART 2: summarize the number of overlapping characters of the individual responses, per group
function result = part2(indiv)
    result = sum(cellfun(@(grp) numer_of_overlaps(grp), indiv));
    function number = numer_of_overlaps(grp)
        common = grp{1};
        for j = 2:length(grp)
            if ~isempty(grp{j})
                common = intersect(common, grp{j});
            end
        endfor
        number = length(common);
    endfunction
endfunction
