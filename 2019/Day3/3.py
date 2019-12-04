import sys

def solve(inp):
    wires = []
    for line in open(inp):
        line = line.strip().split(",")
        wires += [line]
    r = 0
    c = 0
    count = 0
    w1_dic = {}
    w1 = set()
    for inst in wires[0]:
        dir = inst[0]
        amt = int(inst[1:])
        for i in range(amt):
            count += 1
            if dir == "U":
                r += 1
            elif dir == "D":
                r -= 1
            elif dir == "R":
                c += 1
            elif dir == "L":
                c -= 1
            w1.add((r, c))
            if (r, c) not in w1_dic.keys():
                w1_dic[(r, c)] = count

    r = 0
    c = 0
    count = 0
    w2_dic = {}
    w2 = set()
    for inst in wires[1]:
        dir = inst[0]
        amt = int(inst[1:])
        for i in range(amt):
            count += 1
            if dir == "U":
                r += 1
            elif dir == "D":
                r -= 1
            elif dir == "R":
                c += 1
            elif dir == "L":
                c -= 1
            w2.add((r, c))
            if (r, c) not in w2_dic.keys():
                w2_dic[(r, c)] = count
    inter = w1 & w2
    smallest1 = sys.maxsize
    smallest2 = sys.maxsize
    for r, c in inter:
        if abs(r) + abs(c) < smallest1:
            smallest1 = abs(r) + abs(c)
        if w1_dic[(r, c)] + w2_dic[(r, c)] < smallest2:
            smallest2 = w1_dic[(r, c)] + w2_dic[(r, c)]
    print("Part 1:", smallest1)
    print("Part 2:", smallest2)

if __name__ == '__main__':
    inp = "input.txt"
    solve(inp)