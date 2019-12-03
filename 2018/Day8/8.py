total_sum = 0
inp = ""

def traverse(index):
    global total_sum
    global inp
    children = int(inp[index])
    meta = int(inp[index + 1])
    index += 2
    if children == 0:
        temp_sum = 0
        for i in range(meta):
            temp_sum += int(inp[index + i])
        print(inp)
        inp = inp[:index - 2] + inp[index + meta:]
        print(inp)
        total_sum += temp_sum
    else:
        for i in range(children):
            traverse(index)



def main():
    """
    2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2
    A----------------------------------
        B----------- C-----------
                         D-----
    """
    global inp
    inp = ""
    for line in open("input.txt"):
        inp += line.strip()
    inp = inp.split()
    inp = [2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2]
    traverse(0)
    print(total_sum)

if __name__ == '__main__':
    main()