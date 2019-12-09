import itertools
last = 0

def getVal(opcodes, mode, val):
    if mode == 0:
        return opcodes[val]
    if mode == 1:
        return val

def part1(numb, inp):
    global last
    opcodes = []
    for line in open(inp):
        line = line.strip().split(",")
        for num in line:
            opcodes += [int(num)]
    index = 0
    ft = True
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
            s1 = opcodes[index + 1]
            s2 = opcodes[index + 2]
            dest = opcodes[index + 3]
            s1 = getVal(opcodes, p1, s1)
            s2 = getVal(opcodes, p2, s2)
            opcodes[dest] = s1 + s2
            index += 4
        elif op == 2:
            s1 = opcodes[index + 1]
            s2 = opcodes[index + 2]
            dest = opcodes[index + 3]
            opcodes[dest] = getVal(opcodes, p1, s1) * getVal(opcodes, p2, s2)
            index += 4
        elif op == 3:
            address = opcodes[index + 1]
            if ft:
                opcodes[address] = numb
                ft = False
            else:
                opcodes[address] = int(last)
            index += 2
        elif op == 4:
            address = opcodes[index + 1]
            if opcodes[address] != 0:
                return opcodes[address]
            index += 2
        elif op == 5:
            s1 = opcodes[index + 1]
            s2 = opcodes[index + 2]
            p1 = getVal(opcodes, p1, s1)
            p2 = getVal(opcodes, p2, s2)
            if p1 != 0:
                index = p2
            else:
                index += 3
        elif op == 6:
            s1 = opcodes[index + 1]
            s2 = opcodes[index + 2]
            p1 = getVal(opcodes, p1, s1)
            p2 = getVal(opcodes, p2, s2)
            if p1 == 0:
                index = p2
            else:
                index += 3
        elif op == 7:
            s1 = opcodes[index + 1]
            s2 = opcodes[index + 2]
            dest = opcodes[index + 3]
            p1 = getVal(opcodes, p1, s1)
            p2 = getVal(opcodes, p2, s2)
            if p1 < p2:
                opcodes[dest] = 1
            else:
                opcodes[dest] = 0
            index += 4
        elif op == 8:
            s1 = opcodes[index + 1]
            s2 = opcodes[index + 2]
            dest = opcodes[index + 3]
            p1 = getVal(opcodes, p1, s1)
            p2 = getVal(opcodes, p2, s2)
            if p1 == p2:
                opcodes[dest] = 1
            else:
                opcodes[dest] = 0
            index += 4
        elif op == 99:
            return last

def part2(numb, thruster_number, opcodes):
    global last
    ft = True
    index = 0
    if last == 139629729:
        h = 1
        pass
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
            s1 = opcodes[index + 1]
            s2 = opcodes[index + 2]
            dest = opcodes[index + 3]
            s1 = getVal(opcodes, p1, s1)
            s2 = getVal(opcodes, p2, s2)
            opcodes[dest] = s1 + s2
            index += 4
        elif op == 2:
            s1 = opcodes[index + 1]
            s2 = opcodes[index + 2]
            dest = opcodes[index + 3]
            opcodes[dest] = getVal(opcodes, p1, s1) * getVal(opcodes, p2, s2)
            index += 4
        elif op == 3:
            address = opcodes[index + 1]
            if ft:
                opcodes[address] = numb
                ft = False
            else:
                opcodes[address] = int(last)
            index += 2
        elif op == 4:
            address = opcodes[index + 1]
            if opcodes[address] != 0:
                return opcodes[address], False, opcodes
            index += 2
        elif op == 5:
            s1 = opcodes[index + 1]
            s2 = opcodes[index + 2]
            p1 = getVal(opcodes, p1, s1)
            p2 = getVal(opcodes, p2, s2)
            if p1 != 0:
                index = p2
            else:
                index += 3
        elif op == 6:
            s1 = opcodes[index + 1]
            s2 = opcodes[index + 2]
            p1 = getVal(opcodes, p1, s1)
            p2 = getVal(opcodes, p2, s2)
            if p1 == 0:
                index = p2
            else:
                index += 3
        elif op == 7:
            s1 = opcodes[index + 1]
            s2 = opcodes[index + 2]
            dest = opcodes[index + 3]
            p1 = getVal(opcodes, p1, s1)
            p2 = getVal(opcodes, p2, s2)
            if p1 < p2:
                opcodes[dest] = 1
            else:
                opcodes[dest] = 0
            index += 4
        elif op == 8:
            s1 = opcodes[index + 1]
            s2 = opcodes[index + 2]
            dest = opcodes[index + 3]
            p1 = getVal(opcodes, p1, s1)
            p2 = getVal(opcodes, p2, s2)
            if p1 == p2:
                opcodes[dest] = 1
            else:
                opcodes[dest] = 0
            index += 4
        elif op == 99:
            return last, True, opcodes

def main():
    global last
    inp = "input.txt"
    part1_list = [0, 1, 2, 3, 4]
    maxi = 0
    tot = 0
    order = (0, 1, 2, 3, 4)
    for x in itertools.permutations(part1_list):
        last = 0
        for num in x:
            tot = part1(num, inp)
            last = tot
        if tot > maxi:
            maxi = tot
            order = x
    part2_list = [5, 6, 7, 8, 9]
    maxi2 = 0
    order = (0, 1, 2, 3, 4)
    opcodes1 = []
    for line in open(inp):
        line = line.strip().split(",")
        for num in line:
            opcodes1 += [int(num)]
    opcodes2 = opcodes1.copy()
    opcodes3 = opcodes1.copy()
    opcodes4 = opcodes1.copy()
    opcodes5 = opcodes1.copy()
    all_opcodes = {}
    all_opcodes[1] = opcodes1
    all_opcodes[2] = opcodes2
    all_opcodes[3] = opcodes3
    all_opcodes[4] = opcodes4
    all_opcodes[5] = opcodes5

    for x in itertools.permutations(part2_list):
        last = 0
        index = 0
        broken = False
        last_thruster_total = 0
        # x = (9, 8, 7, 6, 5)
        while not broken:
            tot, broken, all_opcodes[index + 1] = part2(x[index], index + 1,
                                                        all_opcodes[index + 1])
            if not broken:
                last = tot
                if last == 139629729:
                    print(last)
            if index == 4:
                last_thruster_total = tot
                if last_thruster_total == 139629729:
                    print(last)
                index = 0
            else:
                index += 1
        if last_thruster_total > maxi2:
            maxi2 = last_thruster_total
            order = x
    print("Part 1:", maxi)
    print("Part 2:", maxi2)

    # print(order)

if __name__ == '__main__':
    main()