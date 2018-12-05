def main():
    twos = 0
    threes = 0
    box = {}
    for line in open("input.txt"):
        line = line.strip()
        box[line] = 0
        dic = {}
        ftwo = True
        fthree = True
        for i in line:
            if i in dic.keys():
                dic[i] += 1
            else:
                dic[i] = 1
        for j in dic.keys():
            if dic[j] == 2 and ftwo is True:
                twos += 1
                ftwo = False
            if dic[j] == 3 and fthree is True:
                threes += 1
                fthree = False
    print(twos * threes)
    k1 = None
    k2 = None
    broken = False
    for key in box.keys():
        for key2 in box.keys():
            if key == key2:
                pass
            else:
                total = 0
                for i in range(0, len(key)):
                    if key[i] == key2[i]:
                        total += 1
                if total == len(key) - 1:
                    k1 = key
                    k2 = key2
                    broken = True
                    break
        if broken == True:
            break
    st = ""
    diff1 = ""
    diff2 = ""
    for k in range(0, len(key)):
        if k1[k] == k2[k]:
            st += k1[k]
        else:
            diff1 += k1[k] 
            diff2 += k2[k] 
                    
    print(st)
    print(diff1 + ", " + diff2)
    return True

if __name__ == '__main__':
    main()
