from collections import defaultdict

total = 0
dic2 = defaultdict(int)
dic3 = defaultdict(set)

def solve(inp):
    dic = defaultdict(set)
    for line in open(inp):
        line = line.strip().split(")")
        dic[line[0]].add(line[1])
    traverse(dic, dic["COM"], 1)
    print("Part 1:", total)
    traverse2(dic, dic["COM"], 1, {"COM"})
    ft = True
    mini = ("", {})
    for k, v in dic3.items():
        if ft and "SAN" in v and "YOU" in v:
            mini = (k, v)
        elif "SAN" in v and "YOU" in v:
            if len(v) < len(mini[1]):
                mini = (k, v)
    san = bfs(mini[0], "SAN", dic)
    you = bfs(mini[0], "YOU", dic)
    print("Part 2:", san + you - 2)


def bfs(start, end, dic):
    visited = defaultdict(int)
    queue = []
    visited[start] = 1
    queue.append((start, 0))
    while len(queue) != 0:
        current = queue[0]
        queue = queue[1:]
        if current[0] == end:
            return visited[end]
        for e in dic[current[0]]:
            if visited[e] == 0:
                queue += [(e, current[1] + 1)]
                visited[e] = current[1] + 1

def traverse(dic, curr, count):
    global total
    for o in curr:
        dic2[o] += count
        total += count
        if o not in dic.keys():
            pass
        else:
            traverse(dic, dic[o], count + 1)

def traverse2(dic, curr, count, sets):
    global total
    for o in curr:
        for s in sets:
            dic3[s].add(o)
        dic2[o] += count
        total += count
        if o not in dic.keys():
            pass
        else:
            temp = sets.copy()
            temp.add(o)
            traverse2(dic, dic[o], count + 1, temp)

if __name__ == '__main__':
    inp = "input.txt"
    solve(inp)