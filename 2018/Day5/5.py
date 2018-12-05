from collections import defaultdict

def getval(poly):
    count = 0
    while count != len(poly) - 1:
        if poly[count].isupper():
            if poly[count + 1].islower() and poly[count].lower() == poly[count + 1]:
                poly = poly[:count] + poly[count + 2:]
                count = count - 1
                if count < 0:
                    count = 0
            else:
                count += 1
        else:
            if poly[count + 1].isupper() and poly[count].upper() == poly[count + 1]:
                poly = poly[:count] + poly[count + 2:]
                count = count - 1
                if count < 0:
                    count = 0
            else:
                count += 1
    return count + 1

def main():
    poly = ""
    for line in open("input.txt"):
        poly += line.strip("\n")
    checked = defaultdict(int)
    counts = defaultdict(int)
    for i in poly:
        if checked[i.lower()] == 0:
            cut = poly.replace(i.lower(), "")
            cut = cut.replace(i.upper(), "")
            checked[i.lower()] = 1
            counts[i.lower()] = getval(cut)
    max = ("", 5000)
    for k,v in counts.items():
        if v < max[1]:
            max = (k, v)
    print(getval(poly))
    print(max)
    trim = poly.replace(max[0].lower(), "")
    trim = trim.replace(max[0].upper(), "")
    trim = getval(trim)
    print(trim)

if __name__ == '__main__':
    main()
    