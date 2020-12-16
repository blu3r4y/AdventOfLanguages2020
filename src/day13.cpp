// Advent of Code 2020, Day 13
// (c) blu3r4y

#include <algorithm>
#include <iostream>
#include <fstream>
#include <sstream>
#include <utility>
#include <numeric>
#include <string>
#include <vector>
#include <tuple>

// puzzle input path
#define INPUT_PATH "./data/day13.txt"

// function prototypes
int part1(int departure, std::vector<int> *bids);
long part2(int departure, std::vector<int> *bids);
std::tuple<__int128, __int128, __int128> xgcd(__int128 a, __int128 b);
std::pair<int, std::vector<int>> load(std::string path);

int main()
{
    auto input = load(INPUT_PATH);
    std::cout << part1(input.first, &input.second) << std::endl;
    std::cout << part2(input.first, &input.second) << std::endl;
    return 0;
}

int part1(int departure, std::vector<int> *bids)
{
    // earliest_bid will hold the id of the next (and earliest) bus we can catch
    int max_mod = 0, earliest_bid = -1;

    for (auto i = 0; i < bids->size(); i++)
    {
        // ignore 'x' values that are represented by zeros
        int bid = (*bids)[i];
        if (bid > 0)
        {
            // compute the modulos and also remember the maximum
            int mod = departure % bid;
            if (mod > max_mod)
            {
                max_mod = mod;
                earliest_bid = bid;
            }
        }
    }

    // the timestamp at which we can board this bus
    int board = departure - (departure % earliest_bid) + earliest_bid;

    // the time we have to wait
    int wait = board - departure;

    return earliest_bid * wait;
}

long part2(int departure, std::vector<int> *bids)
{
    // get a list of tuples holding the index and bid values
    std::vector<std::pair<__int128, __int128>> constraints;
    for (auto i = 0; i < bids->size(); i++)
    {
        // ignore 'x' values that are represented by zeros
        int bid = (*bids)[i];
        if (bid > 0)
        {
            constraints.push_back({i, bid});
        }
    }

    // given two moduli `an = (a1, n1)` and `bn = (a2, n2)` solves the congruence equation
    // of `x = a1 (mod n1)` and `x = a2 (mod n2)` for `x` by the Chinese Remainder Theorem
    // and therefore returns `xn = (x, n1 * n2)`
    // (c) https://en.wikipedia.org/wiki/Chinese_remainder_theorem#Case_of_two_moduli
    auto chinese_remainder_theorem = [](std::pair<__int128, __int128> an, std::pair<__int128, __int128> bn) {
        __int128 a1 = an.first, n1 = an.second;
        __int128 a2 = bn.first, n2 = bn.second;

        // Bézout's Identity holds if n1 and n2 are co-prime
        // m1*n1 + m2*n2 = 1 = gcd(n1, n2)
        auto gcd_m1_m2 = xgcd(n1, n2);
        __int128 m1 = std::get<1>(gcd_m1_m2);
        __int128 m2 = std::get<2>(gcd_m1_m2);

        // reduce a and b to a new constraint y = x (mod n1*n2)
        __int128 x = (a1 * m2 * n2) + (a2 * m1 * n1);
        __int128 n = n1 * n2;

        return std::make_pair(x % n, n);
    };

    // solve the general case of the Chinese Remainder Theorem via reduction
    // (c) https://en.wikipedia.org/wiki/Chinese_remainder_theorem#Existence_(constructive_proof)
    auto xn = std::accumulate(constraints.begin() + 1, constraints.end(), constraints[0], chinese_remainder_theorem);
    __int128 n = xn.first;
    __int128 mod = xn.second;

    // retrieve the smallest possible integer for the final congruence
    long smallest = mod - n % mod;
    return smallest;
}

std::tuple<__int128, __int128, __int128> xgcd(__int128 a, __int128 b)
{
    // applies the Extended Euclidean Algorithm which
    // returns `(g, x, y)` such that `ax + by = g = gcd(a, b)`
    // (c) https://en.wikibooks.org/wiki/Algorithm_Implementation/Mathematics/Extended_Euclidean_algorithm

    __int128 x0 = 0, x1 = 1, y0 = 1, y1 = 0;
    while (a != 0)
    {
        __int128 a_ = a;
        __int128 q = b / a;

        // this is b % a but will always return the sign of a (like Python does)
        a = ((b % a) + a) % a;
        b = a_;

        __int128 y0_ = y0;
        y0 = y1;
        y1 = y0_ - q * y1;

        __int128 x0_ = x0;
        x0 = x1;
        x1 = x0_ - q * x1;
    }

    return {b, x0, y0};
}

std::pair<int, std::vector<int>> load(std::string path)
{
    // open the file
    std::string buffer;
    std::ifstream handle(path);
    if (!handle)
    {
        std::cerr << "can not open file " << INPUT_PATH << std::endl;
        return {0, {}};
    }

    // read the earliest departure time
    std::getline(handle, buffer);
    int departure = std::stoi(buffer);

    // read the bus ids
    std::getline(handle, buffer);
    std::stringstream stream(buffer);

    // close the file
    handle.close();

    // parse the comma-separated list of values
    std::vector<int> bids;
    while (stream.good())
    {
        std::string bidstr;
        std::getline(stream, bidstr, ',');

        // store 'x' values as 0 for now
        int bid = (bidstr == "x") ? 0 : std::stoi(bidstr);
        bids.push_back(bid);
    }

    return {departure, bids};
}
