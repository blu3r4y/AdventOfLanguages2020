// Advent of Code 2020, Day 12
// (c) blu3r4y

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

// puzzle input
#define INPUT_PATH "./data/day12.txt"

// exit codes
#define EXIT_SUCCESS 0
#define EXIT_IO_ERROR 1
#define EXIT_INVALID_CHAR 2
#define EXIT_INVALID_ACTION 3

// global file handle
FILE *INPUT_FILE = NULL;

// function prototypes
int part1();
int part2();
bool next_instruction(char *action, int *value);
void process_instruction(char action, int value, int *x, int *y, int *dx, int *dy);
void rotate_vector(int degrees, int *dx, int *dy);
int manhattan_distance(int x, int y);

int main()
{
    // open the puzzle input file
    INPUT_FILE = fopen(INPUT_PATH, "r");
    if (INPUT_FILE == NULL)
        return EXIT_IO_ERROR;

    // compute the two parts, and read the file on-the-fly
    // yes, twice, because i am lazy when i must program in C
    int ans1 = part1();
    rewind(INPUT_FILE);
    int ans2 = part2();

    // print the final result
    printf("%d\n%d\n", ans1, ans2);

    return EXIT_SUCCESS;
}

int part1()
{
    // instruction buffers
    char action;
    int value;

    // ship position and direction (heading east)
    int x = 0, y = 0;
    int dx = 1, dy = 0;

    // process instruction by instruction
    bool readmore = true;
    while (readmore)
    {
        readmore = next_instruction(&action, &value);
        process_instruction(action, value, &x, &y, &dx, &dy);
        // printf("%c %-3d | pos (%5d, %5d) face (%2d, %2d)\n", action, value, x, y, dx, dy);
    }

    return manhattan_distance(x, y);
}

int part2()
{
    // instruction buffers
    char action;
    int value;

    // ship and waypoint position (with waypoint at [10 1])
    int sx = 0, sy = 0;
    int wx = 10, wy = 1;

    // process instruction by instruction
    bool readmore = true;
    while (readmore)
    {
        readmore = next_instruction(&action, &value);

        if (action == 'F')
        {
            // advance the ship with the waypoint vector
            sx += wx * value;
            sy += wy * value;
        }
        else
        {
            // always advance or rotate the waypoint only
            process_instruction(action, value, &wx, &wy, &wx, &wy);
        }
    }

    return manhattan_distance(sx, sy);
}

bool next_instruction(char *action, int *value)
{
    // store the value characters in this string
    char buffer[10];
    int i = 0;

    // read the first character
    char ch = (char)fgetc(INPUT_FILE);
    do
    {
        if ('A' <= ch && ch <= 'Z')
        {
            // return the action per reference
            *action = ch;
        }
        else if ('0' <= ch && ch <= '9')
        {
            // store the characters, parse the number later
            buffer[i] = ch;
            i++;
        }
        else
        {
            exit(EXIT_INVALID_CHAR);
        }

        // read the next character
        ch = (char)fgetc(INPUT_FILE);
    } while (ch != EOF && ch != '\n');

    // parse and return the number per reference
    buffer[i] = '\0';
    *value = atoi(buffer);

    // peek if the next read would already return EOF
    ch = (char)fgetc(INPUT_FILE);
    ungetc(ch, INPUT_FILE);

    // only return true if there are more instructions
    return ch != EOF;
}

void process_instruction(char action, int value, int *x, int *y, int *dx, int *dy)
{
    switch (action)
    {
    case 'N':
        // move north
        *y += value;
        break;
    case 'S':
        // move south
        *y -= value;
        break;
    case 'E':
        // move east
        *x += value;
        break;
    case 'W':
        // move west
        *x -= value;
        break;
    case 'L':
        // turn left by given number of degrees
        rotate_vector(-value, dx, dy);
        break;
    case 'R':
        // turn right by given number of degrees
        rotate_vector(value, dx, dy);
        break;
    case 'F':
        // move forward in given direction
        *x += *dx * value;
        *y += *dy * value;
        break;
    default:
        exit(EXIT_INVALID_ACTION);
        break;
    }
}

void rotate_vector(int degrees, int *dx, int *dy)
{
    if (degrees < 0)
    {
        // rewrite left rotations to right rotations
        degrees = 360 + degrees;
    }

    int times = degrees / 90;
    for (int i = 0; i < times; i++)
    {
        int dx_ = *dx;

        // (dx, dy) becomes (-dy, dx)
        *dx = *dy;
        *dy = dx_ * (-1);
    }
}

int manhattan_distance(int x, int y)
{
    return abs(x) + abs(y);
}
