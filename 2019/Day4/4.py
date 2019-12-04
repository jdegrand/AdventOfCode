def meetsCriteria(number):
    doub = False
    previous = -1
    st = str(number)
    for i in range(len(st)):
        if previous == int(st[i]):
            doub = True
        elif previous > int(st[i]):
            return False
        previous = int(st[i])
    return doub

def meetsMoreCriteria(number):
    previous = -1
    st = str(number)
    count = 1
    counts = set()
    for i in range(len(st)):
        if previous == int(st[i]):
            count += 1
        elif previous > int(st[i]):
            return False
        else:
            counts.add(count)
            count = 1
        previous = int(st[i])
    counts.add(count)
    return 2 in counts

def solve(inp):
    """
    278384-824795
    """
    upper, lower = 0, 0
    for line in open(inp):
        line = line.strip().split("-")
        lower = int(line[0])
        upper = int(line[1])
    count = 0
    count2 = 0
    for i in range(lower, upper + 1):
        if meetsCriteria(i):
            count += 1
        if meetsMoreCriteria(i):
            count2 += 1
    print("Part 1:", count)
    print("Part 2:", count2)

if __name__ == '__main__':
    print(meetsMoreCriteria(111122))
    inp = "input.txt"
    solve(inp)