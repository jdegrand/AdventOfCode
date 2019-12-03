def calcFuel(mass):
    temp = (mass // 3) - 2
    if temp > 0:
        return temp + calcFuel(temp)
    return 0


def part1(inp):
    total = 0
    for line in open(inp):
        mass = int(line.strip())
        mass = (mass // 3) - 2
        total += mass
    print("Part 1:", total)

def part2(inp):
    total = 0
    for line in open(inp):
        mass = int(line.strip())
        total += calcFuel(mass)
    print("Part 2:", total)


if __name__ == '__main__':
    inp = "input.txt"
    part1(inp)
    part2(inp)