from collections import defaultdict

def manhattan(p1, p2):
    return abs(p1[0] - p2[0]) + abs((p1[1] - p2[1]))

def get_edges(all_points, minx, miny, maxx, maxy):
    edges = []
    for i in range(minx[0], maxx[0] + 1):
        edges += [(i, miny[1])]
    for j in range(minx[0], maxx[0] + 1):
        edges += [(j, maxy[1])]
    for k in range(miny[1], maxy[1] + 1):
        edges += [(minx[0], k)]
    for l in range(miny[1], maxy[1] + 1):
        edges += [(maxx[0], l)]
    owners = []
    for item in edges:
        piece = all_points[item]
        if piece not in owners:
            owners += [piece]
    return owners

def isedge(p, edges):
    if p in edges:
        return True
    return False

def main():
    ls = []
    dic = defaultdict(int)
    # First in input
    minx = (174, 136)
    maxx = (174, 136)
    miny = (174, 136)
    maxy = (174, 136)
    for line in open("input.txt"):
        line = line.strip("\n").split(", ")
        tup = (int(line[0]), int(line[1]))
        ls += [tup]
        if tup[0] < minx[0]:
            minx = tup
        if tup[0] > maxx[0]:
            maxx = tup
        if tup[1] < miny[1]:
            miny = tup
        if tup[1] > maxy[1]:
            maxy = tup
    vals = defaultdict(int)
    points = defaultdict(int)
    distance = defaultdict(int) # Distance from all coordinates for Part 2
    for r in range(minx[0], maxx[0] + 1):
        for c in range(miny[1], maxy[1] + 1):
            shortest = 10000000
            spoint = (0, 0)
            hit = False
            for e in ls:
                man = manhattan(e, (r, c))
                distance[(r, c)] += man
                if man < shortest:
                    shortest = man
                    spoint = e
                    hit = False
                elif man == shortest:
                    hit = True
            if not hit:
                vals[spoint] += 1
                points[(r, c)] = spoint
    edges = get_edges(points, minx, miny, maxx, maxy)
    most = 0
    for i in ls:
        if vals[i] > most and not isedge(i, edges):
            most = vals[i]
    print(most)
    total = 0
    for k in distance.keys():
        if distance[k] < 10000:
            total += 1
    print(total)

if __name__ == '__main__':
    main()
    