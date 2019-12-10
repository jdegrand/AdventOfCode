from collections import defaultdict

relative = 0

def getVal(opcodes, mode, val):
    if mode == 0 or mode == 2:
        return opcodes[val]
    if mode == 1:
        return val

def getAddress(opcodes, mode, index):
    if mode == 2:
        return opcodes[relative]
    return opcodes[index]

def part2(inp):
    global relative
    opcodes = defaultdict(int)
    ind = 0
    for line in open(inp):
        line = line.strip().split(",")
        for num in line:
            opcodes[ind] += int(num)
            ind += 1
    index = 0
    while True:
        p1 = 0
        p2 = 0
        p3 = 0
        op = str(opcodes[index])
        if len(op) == 1:
            op = int(op)
        elif len(op) == 2:
            op = int(op)
        elif len(op) == 3:
            p1 = int(op[0])
            op = int(op[1:])
        elif len(op) == 4:
            p2 = int(op[0])
            p1 = int(op[1])
            op = int(op[2:])
        elif len(op) == 5:
            p3 = int(op[0])
            p2 = int(op[1])
            p1 = int(op[2])
            op = int(op[3:])
        if op == 1:
            s1 = getAddress(opcodes, p1, index + 1)
            s2 = getAddress(opcodes, p2, index + 2)
            dest = getAddress(opcodes, p3, index + 3)
            s1 = getVal(opcodes, p1, s1)
            s2 = getVal(opcodes, p2, s2)
            opcodes[dest] = s1 + s2
            index += 4
        elif op == 2:
            s1 = getAddress(opcodes, p1, index + 1)
            s2 = getAddress(opcodes, p2, index + 2)
            dest = getAddress(opcodes, p3, index + 3)
            opcodes[dest] = getVal(opcodes, p1, s1) * getVal(opcodes, p2, s2)
            index += 4
        elif op == 3:
            address = getAddress(opcodes, p1, index + 1)
            opcodes[address] = int(input("Part 2: "))
            index += 2
        elif op == 4:
            address = getAddress(opcodes, p1, index + 1)
            print(getVal(opcodes, p1, address))
            index += 2
        elif op == 5:
            s1 = getAddress(opcodes, p1, index + 1)
            s2 = getAddress(opcodes, p2, index + 2)
            p1 = getVal(opcodes, p1, s1)
            p2 = getVal(opcodes, p2, s2)
            if p1 != 0:
                index = p2
            else:
                index += 3
        elif op == 6:
            s1 = getAddress(opcodes, p1, index + 1)
            s2 = getAddress(opcodes, p2, index + 2)
            p1 = getVal(opcodes, p1, s1)
            p2 = getVal(opcodes, p2, s2)
            if p1 == 0:
                index = p2
            else:
                index += 3
        elif op == 7:
            s1 = getAddress(opcodes, p1, index + 1)
            s2 = getAddress(opcodes, p2, index + 2)
            dest = getAddress(opcodes, p3, index + 3)
            p1 = getVal(opcodes, p1, s1)
            p2 = getVal(opcodes, p2, s2)
            if p1 < p2:
                opcodes[dest] = 1
            else:
                opcodes[dest] = 0
            index += 4
        elif op == 8:
            s1 = getAddress(opcodes, p1, index + 1)
            s2 = getAddress(opcodes, p2, index + 2)
            dest = getAddress(opcodes, p3, index + 3)
            p1 = getVal(opcodes, p1, s1)
            p2 = getVal(opcodes, p2, s2)
            if p1 == p2:
                opcodes[dest] = 1
            else:
                opcodes[dest] = 0
            index += 4
        elif op == 9:
            relative_change = getAddress(opcodes, p1, index + 1)
            relative += relative_change
            index += 2
        elif op == 99:
            break

if __name__ == '__main__':
    inp = "input.txt"
    part2(inp)