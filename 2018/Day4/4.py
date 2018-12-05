from collections import defaultdict

def main():
    dic = defaultdict(int)
    dic = {}
    # ID, {minute, 0}
    sor = []
    for feed in open('input.txt'):
        sor += [feed]
    sor.sort()
    asleep = 0
    awake = 0
    for line in sor:
        line = line.strip()
        if "Guard" in line:
            current = line.split(' ')[3]
            if current not in dic.keys():
                dic[current] = [defaultdict(int), 0]
        elif "asleep" in line:
            asleep = line.split(' ')[1].strip("]")
        elif "wakes" in line:
            awake = line.split(' ')[1].strip("]")
            asleep = int(asleep.split(":")[1]) 
            awake = int(awake.split(":")[1]) 
            for i in range(asleep, awake):
                dic[current][0][i] += 1
                dic[current][1] += 1
    most = 0
    guard = ""
    for j in dic.keys():
        curr = dic[j]
        if curr[1] > most:
            most = curr[1]
            guard = j
    print(guard)
    minute = 0
    max_minutes = 0
    for k, v in dic[guard][0].items():
        if v > max_minutes:
            max_minutes = v
            minute = k

    for k, v in dic[guard][0].items():
        if v > max_minutes:
            max_minutes = v
            minute = k
    lh = (("", 0), ("", 0))
    mins = defaultdict(int)

    for g in dic.keys():
        for k1, v2 in dic[g][0].items():
            if mins[k1] == 0:
                mins[k1] = [("", 0, 0), (g, v2, 0)]
            elif v2 > mins[k1][1][1]:
                mins[k1][0] = mins[k1][1]
                mins[k1][1] = (g, v2, k1)
            elif v2 > mins[k1][0][1]:
                mins[k1][0] = (g, v2, k1)
    diff = ["", 0, 0]
    for h in mins.keys():
        temp = mins[h][1][1] - mins[h][0][1]
        if temp > diff[1]:
            diff[0] = mins[h][1][0]
            diff[1] = temp
            diff[2] = mins[h][1][2]
    print(minute)
    print(diff)

    



if __name__ == '__main__':
    main()
