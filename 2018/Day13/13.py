from collections import defaultdict
import time

def getSize():
    ft = True
    cols = 0
    rows = 1
    for line in open("input.txt"):
        ljne = line.strip()
        if ft is True:
            cols = len(line)
            ft = False
        rows += 1
    return rows - 1, cols - 1

def order(i):
    x = i[2][0]
    y = i[2][1]
    return x, y

def main():
    # tracks = defaultdict(str)
    carts = defaultdict(list)
    cartno = 1
    cartlist = []
    rows, cols = getSize()
    tracks = [[0 for x in range(cols)] for x in range(rows)]
    blanktracks = [[0 for x in range(cols)] for x in range(rows)]
    print(rows, cols)
    rcount = 0
    for line in open("input.txt"):
        line = line.strip("\n")
        for c in range(0, cols):
            if line[c] == ">" or line[c] == "<" or line[c] == "^" or line[c] == "v":
                cartlist += [[line[c], "l", (rcount, c)]]
                carts[cartno] = [line[c], "l", (rcount, c)]
                cartno += 1
                if line[c] == ">" or line[c] == "<":
                    blanktracks[rcount][c] = '-'
                else:
                    blanktracks[rcount][c] = '|'
            else:
                blanktracks[rcount][c] = line[c]
            tracks[rcount][c] = line[c]
        rcount += 1
    broken = False
    afterTick = False
    while True:
        # [line[c], "l", (rcount, c)]
        # time.sleep(0.5)
        for i in range(0, rows):
            print(''.join(tracks[i]))

        if afterTick:
            print("Position of last cart is:", (cartlist[0][2][1], cartlist[0][2][0]))
            break
        if len(cartlist) == 1:
            afterTick = True
        new = []
        for cart in cartlist:
            r = cart[2][0]
            c = cart[2][1]
            if cart[0] == "<":
                move = tracks[r][c - 1]
                if move == ">" or move == "<" or move == "^" or move == "v":
                    print((c - 1, r))
                    cart[0] = 'X'
                    tracks[r][c] = blanktracks[r][c]
                elif move == '\\':
                    tracks[r][c - 1] = '^'
                    cart[0] = '^'
                    tracks[r][c] = blanktracks[r][c]
                elif move == '/':
                    tracks[r][c - 1] = 'v'
                    cart[0] = 'v'
                    tracks[r][c] = blanktracks[r][c]
                elif move == '+':
                    if cart[1] == "l":
                        cart[1] = "m"
                        tracks[r][c - 1] = 'v'
                        cart[0] = 'v'
                    elif cart[1] == "m":
                        cart[1] = "r"
                        tracks[r][c - 1] = '<'
                        cart[0] = '<'
                    else:
                        cart[1] = "l"
                        tracks[r][c - 1] = '^'
                        cart[0] = '^'
                    tracks[r][c] = blanktracks[r][c]
                else:
                    tracks[r][c - 1] = '<'
                    tracks[r][c] = blanktracks[r][c]
                cart[2] = (r, c - 1)
                if cart[0] != 'X':
                    new += [cart]
            elif cart[0] == ">":
                move = tracks[r][c + 1]
                if move == ">" or move == "<" or move == "^" or move == "v":
                    print((c + 1, r))
                    cart[0] = 'X'
                    tracks[r][c] = blanktracks[r][c]
                elif move == '\\':
                    tracks[r][c + 1] = 'v'
                    cart[0] = 'v'
                    tracks[r][c] = blanktracks[r][c]
                elif move == '/':
                    tracks[r][c + 1] = '^'
                    cart[0] = '^'
                    tracks[r][c] = blanktracks[r][c]
                elif move == '+':
                    if cart[1] == "l":
                        cart[1] = "m"
                        tracks[r][c + 1] = '^'
                        cart[0] = '^'
                    elif cart[1] == "m":
                        cart[1] = "r"
                        tracks[r][c + 1] = '>'
                        cart[0] = '>'
                    else:
                        cart[1] = "l"
                        tracks[r][c + 1] = 'v'
                        cart[0] = 'v'
                    tracks[r][c] = blanktracks[r][c]
                else:
                    tracks[r][c + 1] = '>'
                    tracks[r][c] = blanktracks[r][c]
                cart[2] = (r, c + 1)
                if cart[0] != 'X':
                    new += [cart]
            elif cart[0] == "^":
                move = tracks[r - 1][c]
                if move == ">" or move == "<" or move == "^" or move == "v":
                    print((c, r - 1))
                    cart[0] = 'X'
                    tracks[r][c] = blanktracks[r][c]
                elif move == '\\':
                    tracks[r - 1][c] = '<'
                    cart[0] = '<'
                    tracks[r][c] = blanktracks[r][c]
                elif move == '/':
                    tracks[r - 1][c] = '>'
                    cart[0] = '>'
                    tracks[r][c] = blanktracks[r][c]
                elif move == '+':
                    if cart[1] == "l":
                        cart[1] = "m"
                        tracks[r - 1][c] = '<'
                        cart[0] = '<'
                    elif cart[1] == "m":
                        cart[1] = "r"
                        tracks[r - 1][c] = '^'
                        cart[0] = "^"
                    else:
                        cart[1] = "l"
                        tracks[r - 1][c] = '>'
                        cart[0] = '>'
                    tracks[r][c] = blanktracks[r][c]
                else:
                    tracks[r - 1][c] = '^'
                    tracks[r][c] = blanktracks[r][c]
                cart[2] = (r - 1, c)
                if cart[0] != 'X':
                    new += [cart]
            elif cart[0] == "v":
                move = tracks[r + 1][c]
                if move == ">" or move == "<" or move == "^" or move == "v":
                    print((c, r + 1))
                    cart[0] = 'X'
                    tracks[r][c] = blanktracks[r][c]
                elif move == '\\':
                    tracks[r + 1][c] = '>'
                    cart[0] = '>'
                    tracks[r][c] = blanktracks[r][c]
                elif move == '/':
                    tracks[r + 1][c] = '<'
                    cart[0] = '<'
                    tracks[r][c] = blanktracks[r][c]
                elif move == '+':
                    if cart[1] == "l":
                        cart[1] = "m"
                        tracks[r + 1][c] = '>'
                        cart[0] = '>'
                    elif cart[1] == "m":
                        cart[1] = "r"
                        tracks[r + 1][c] = 'v'
                        cart[0] = 'v'
                    else:
                        cart[1] = "l"
                        tracks[r + 1][c] = '<'
                        cart[0] = '<'
                    tracks[r][c] = blanktracks[r][c]
                else:
                    tracks[r + 1][c] = 'v'
                    tracks[r][c] = blanktracks[r][c]
                cart[2] = (r + 1, c)
                if cart[0] != 'X':
                    new += [cart]
            cartlist = new
        if broken:
            break

    # for i in range(0, rows):
    #     print(''.join(blanktracks[i]))
    # print(cartno - 1)

    return

if __name__ == '__main__':
    main()