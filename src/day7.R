# Advent of Code 2020, Day 7
# (c) blu3r4y

START <- "shiny_gold"

load <- function(path) {
    data <- list()

    # remove the trailing dot and bag(s) string to make processing easier
    lines <- readLines(path)
    lines <- gsub("\\sbags?", "", gsub("\\.", "", lines))

    for (line in lines) {
        parts <- unlist(strsplit(line, " contain "))

        # get outer and inner bags
        outer <- gsub(" ", "_", parts[1])
        innerList <- unlist(strsplit(parts[2], ", "))

        # check if there really are some bags
        if (grepl("no other", line)) {
            data[[outer]] = NA
        } else {
            innerData = list()

            for (inner in innerList) {
                number <- strtoi(unlist(strsplit(inner, " "))[1])
                bag <- paste(unlist(strsplit(inner, " "))[-1], collapse="_")
                innerData[[bag]] = number
            }

            data[[outer]] = innerData
        }
    }

    return(data)
}

part1 <- function(data) {
    # returns all bags that contain this bag
    predecessors <- function(root) {
        result <- list()
        for (node in names(data)) {
            if (root %in% names(data[[node]])) {
                result <- c(result, node)
            }
        }
        return(result)
    }

    # returns all bags that contain this bag, even recursive
    ancestors <- function(root) {
        result <- list()
        for (pred in predecessors(root)) {
            result <- union(result, pred)
            result <- union(result, c(ancestors(pred)))
        }
        return(result)
    }

    return(length(ancestors(START)))
}

part2 <- function(data) {
    countBags <- function(node) {
        theNode <- data[[node]]

        count <- 1
        if (!is.na(theNode)[[1]]) {
            for (succ in names(theNode)) {
                count <- count + theNode[[succ]] * countBags(succ)
            }
        }

        # count all the inner bags, but don't count the outermost (-1)
        return(count)
    }

    return(countBags(START) - 1)
}

data <- load("./data/day7.txt")
cat(part1(data), "\n")
cat(part2(data))
