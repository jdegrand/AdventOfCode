def problem():
    count = 0
    first_negative = None
    index = 1
    ft = True
    for line in open("input.txt"):
        line = line.strip()
        for ch in line:
            if ch == "(":
                count += 1
            elif ch == ")":
                count -= 1
            if count < 0 and ft is True:
                first_negative = index
                ft = False
            index += 1
    return count, first_negative

def main():
    floors = problem()
    print("Part 1:", floors[0], "\nPart 2:", floors[1])

if __name__ == '__main__':
    main()
