import sys
from collections import defaultdict

def part1(inp):
    dic = defaultdict(list)
    puzzle = ""
    row = 6
    col = 25
    for line in open(inp):
        puzzle = line.strip()
    counter = 0
    layer = 1
    num_zeros = 0
    num_ones = 0
    num_twos = 0
    least_zeros = (0, sys.maxsize, 0, 0)
    for ch in puzzle:
        if counter == row * col:
            if num_zeros < least_zeros[1]:
                least_zeros = (layer, num_zeros, num_ones, num_twos)
            layer += 1
            counter = 0
            num_zeros = 0
            num_ones = 0
            num_twos = 0
        ch = int(ch)
        if ch == 0:
            num_zeros += 1
        elif ch == 1:
            num_ones += 1
        elif ch == 2:
            num_twos += 1
        counter += 1
    if num_zeros < least_zeros[1]:
        least_zeros = (layer, num_zeros, num_ones, num_twos)
    return least_zeros[2] * least_zeros[3]


def part2(inp):
    puzzle = ""
    row = 6
    col = 25
    for line in open(inp):
        puzzle = line.strip()
    counter = 0
    layer = 1
    final_image = [-1 for i in range(row * col)]
    for ch in puzzle:
        if counter == row * col:
            layer += 1
            counter = 0
        ch = int(ch)
        if final_image[counter] == -1 and ch != 2:
            final_image[counter] = ch
        counter += 1
    print("Part 2:")
    index = 0
    col_counter = 0
    while index < len(final_image):
        if final_image[index] == 0:
            print(" ", end='')
        else:
            print(final_image[index], end='')
        if col_counter + 1 == col:
            print()
            col_counter = -1
        index += 1
        col_counter += 1


if __name__ == '__main__':
    inp = "input.txt"
    print("Part 1:", part1(inp))
    part2(inp)