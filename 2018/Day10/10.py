from collections import defaultdict
from turtle import *

"""
position=< 9,  1> velocity=< 0,  2>
position=< 7,  0> velocity=<-1,  0>
position=< 3, -2> velocity=<-1,  1>
position=< 6, 10> velocity=<-2, -1>
position=< 2, -4> velocity=< 2,  2>
position=<-6, 10> velocity=< 2, -2>
position=< 1,  8> velocity=< 1, -1>
position=< 1,  7> velocity=< 1,  0>
position=<-3, 11> velocity=< 1, -2>
position=< 7,  6> velocity=<-1, -1>
position=<-2,  3> velocity=< 1,  0>
position=<-4,  3> velocity=< 2,  0>
position=<10, -3> velocity=<-1,  1>
position=< 5, 11> velocity=< 1, -2>
position=< 4,  7> velocity=< 0, -1>
position=< 8, -2> velocity=< 0,  1>
position=<15,  0> velocity=<-2,  0>
position=< 1,  6> velocity=< 1,  0>
position=< 8,  9> velocity=< 0, -1>
position=< 3,  3> velocity=<-1,  1>
position=< 0,  5> velocity=< 0, -1>
position=<-2,  2> velocity=< 2,  0>
position=< 5, -2> velocity=< 1,  2>
position=< 1,  4> velocity=< 2,  1>
position=<-2,  7> velocity=< 2, -2>
position=< 3,  6> velocity=<-1, -1>
position=< 5,  0> velocity=< 1,  0>
position=<-6,  0> velocity=< 2,  0>
position=< 5,  9> velocity=< 1, -2>
position=<14,  7> velocity=<-2,  0>
position=<-3,  6> velocity=< 2, -1>
"""

def main():
    data = defaultdict(int)
    position = defaultdict(int)
    touched_false = {}
    for line in open("input.txt"):
        line = line.strip("\n").split("v")
        pos = line[0].strip("position=").strip()
        vel = line[1].strip("elocity=").strip()
        pos = pos.strip("<>").strip().split(", ")
        vel = vel.strip("<>").strip().split(", ")
        data[(int(pos[0]), int(pos[1]))] = (int(vel[0]), int(vel[1]))
        position[(int(pos[0]), int(pos[1]))] = (int(pos[0]), int(pos[1]))
        touched_false[(int(pos[0]), int(pos[1]))] = False
    seconds = 0
    while True:
        curr = []
        prnt = defaultdict(int)
        countsx = defaultdict(int)
        countsy = defaultdict(int)
        for k, v in position.items():
            position[k] = (v[0] + data[k][0], v[1] + data[k][1])
            curr += [(v[0] + data[k][0], v[1] + data[k][1])]
            prnt[(v[0] + data[k][0], v[1] + data[k][1])] = 1
            countsx[v[0] + data[k][0]] += 1
            countsy[v[1] + data[k][1]] += 1
        seconds += 1
        broken = False
        for k2, v2 in countsx.items():
            if v2 > 20:
                broken = True
                break
        if broken is True:
            break
    x = [100000000, 0]
    y = [100000000, 0]
    for k, v in prnt.items():
        if k[0] > x[1]:
            x[1] = k[0]
        if k[1] > y[1]:
            y[1] = k[1]
        if k[0] < x[0]:
            x[0] = k[0]
        if k[1] < y[0]:
            y[0] = k[1]
    print(x, y)
    speed("fastest")
    setup(abs(x[1] - x[0]), abs(y[1] - y[0]))
    print(prnt)
    for kp, vp in prnt.items():
        penup()
        goto(kp[0] * 2, kp[1] * -2)
        pendown()
        fillcolor("black")
        circle(1)
    hideturtle()
    done()
    print("Seconds:", seconds)

if __name__ == '__main__':
    main()