from collections import defaultdict

def main():
    start = ""
    transitions = defaultdict(str)
    generations = defaultdict(str)
    geninds = defaultdict(str)
    for line in open("input.txt"):
        line = line.strip()
        if line == "":
            pass
        elif line.split()[0] == "initial":
            start = line.split()[2]
        else:
            line = line.split()
            transitions[line[0]] = line[2]
    inds = []
    for i in range(0, len(start)):
        inds += [i]
    curr = start
    generations[0] = start
    geninds[0] = inds
    gencount = 1
    loop = 0
    prev = None
    oneMore = False
    for i in range(0, 501):
        new = ""
        front = int(inds[0])
        ends = int(inds[len(inds) - 1])
        afront = []
        aback = []
        for i in range(0, 3):
            afront = [front - i - 1] + afront
            aback += [ends + 1 + i]
        inds = afront + inds + aback
        curr = "....." + curr + "....."
        geninds[gencount] = inds
        for j in range(2, len(curr) - 2):
            p = curr[j - 2: j + 3]
            if transitions[p] == "":
                new += "."
            else:
                new += transitions[p]
        curr = new
        generations[gencount] = curr
        gencount += 1
        if oneMore is True:
            break
        if prev == new.strip("."):
            print("LOOP FOUNT AT GEN:", gencount - 1)
            loop = gencount - 1
            oneMore = True
        prev = new.strip(".")
    fcount = 0
    for i in range(0, len(generations[20])):
        if generations[20][i] == "#":
            fcount += geninds[20][i]
    dic = {loop: 0, loop + 1: 0}
    for j in range(loop, loop + 2):
        fcountbig = 0
        for i in range(0, len(generations[j])):
            if generations[j][i] == "#":
                fcountbig += geninds[j][i]
        dic[j] = fcountbig
        print("Generation", str(j) + ",", fcountbig, "flowers!")
    difference = dic[loop + 1] - dic[loop]
    print("Difference in sum found after each loop after Generation", str(loop) + ":", difference)
    part2count = ((50000000000 - loop) * difference) + dic[loop]
    print("After 20 generations there are", fcount, "flowers!")
    print("After 50000000000 generations there are", part2count, "flowers!")

if __name__=='__main__':
    main()