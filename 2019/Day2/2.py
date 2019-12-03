def part1(inp):
    opcodes = []
    for line in open(inp):
        line = line.strip().split(",")
        for num in line:
            opcodes += [int(num)]
    opcodes[1] = 12
    opcodes[2] = 2
    index = 0
    while True:
        op = opcodes[index]
        if op == 1:
            s1 = opcodes[index + 1]
            s2 = opcodes[index + 2]
            dest = opcodes[index + 3]
            opcodes[dest] = opcodes[s1] + opcodes[s2]
        elif op == 2:
            s1 = opcodes[index + 1]
            s2 = opcodes[index + 2]
            dest = opcodes[index + 3]
            opcodes[dest] = opcodes[s1] * opcodes[s2]
        elif op == 99:
            break
        index += 4
    print("Part 1:", opcodes[0])

def part2(inp):
    opcodes = []
    for line in open(inp):
        line = line.strip().split(",")
        for num in line:
            opcodes += [int(num)]
    og = opcodes.copy()
    for noun in range(99):
        for verb in range(99):
            opcodes = og.copy()
            opcodes[1] = noun
            opcodes[2] = verb
            result = calc(opcodes, 0)
            if result == 19690720:
                print("Part 2:", 100 * noun + verb)
                return

def calc(opcodes, index):
    while True:
        op = opcodes[index]
        if op == 1:
            s1 = opcodes[index + 1]
            s2 = opcodes[index + 2]
            dest = opcodes[index + 3]
            opcodes[dest] = opcodes[s1] + opcodes[s2]
        elif op == 2:
            s1 = opcodes[index + 1]
            s2 = opcodes[index + 2]
            dest = opcodes[index + 3]
            opcodes[dest] = opcodes[s1] * opcodes[s2]
        elif op == 99:
            return opcodes[0]
        index += 4


if __name__ == '__main__':
    inp = "input.txt"
    part1(inp)
    part2(inp)