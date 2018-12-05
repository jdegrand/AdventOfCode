def main():
    dic = {}
    fabric = {}
    for line in open("input.txt"):
        line = line.strip()
        line = line.split(" ")
        ident = line[0][1:]
        padding = line[2].split(",")
        row = padding[0]
        col = padding[1][:len(padding[1]) - 1]
        size = line[3].split("x")
        width = size[0]
        height = size[1]
        dic[ident] = [int(row), int(col), int(width), int(height)]
    for i in range(0, 5000):
        fabric[i] = [0] * 5000
    for key in dic.keys():
        curr = dic[key]
        row = curr[0]
        col = curr[1]
        width = curr[2]
        height = curr[3]
        for w in range(0, width):
            for h in range(0, height):
                fabric[row + w][col + h] += 1
    total = 0
    for new in fabric.keys():
        for l in range(0, len(fabric[new])):
            if fabric[new][l] >= 2:
                total += 1
    for claim in dic.keys():
        curr = dic[claim]
        row = curr[0]
        col = curr[1]
        width = curr[2]
        height = curr[3]
        broken = False
        for w in range(0, width):
            for h in range(0, height):
                if fabric[row + w][col + h] != 1:
                    broken = True
                    break
            if broken is True:
                break
        if broken is not True:
            print(claim)
    print(total)

if __name__ == '__main__':
    main()