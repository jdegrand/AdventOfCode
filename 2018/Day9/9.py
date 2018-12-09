from collections import defaultdict

# 473 players; last marble is worth 70904 points

class LinkedList:
    def __init__(self, front, curr, end, length):
        self.front = front
        self.curr = curr
        self.end = end
        self.length = length

    def add_node(self, val):
        temp = Node(None, val, None)
        temp.prev = self.curr
        temp.nex = self.curr.nex
        self.curr.nex.prev = temp
        self.curr.nex = temp
        self.curr = self.curr.nex
        self.length += 1

class Node:
    def __init__(self, prev, value, nex):
        self.prev = prev
        self.value = value
        self.nex = nex

def main():
    inp = ""
    for line in open("input.txt"):
        line = line.strip("\n").split()
        inp = line
    parts = [("Part 1:", int(inp[6])), ("Part 2:", int(inp[6]) * 100)]
    for part in parts:
        score = defaultdict(int)
        temp = Node(None, 0, None)
        ll = LinkedList(None, None, None, 0)
        ll.length += 1
        temp.prev = temp
        temp.nex = temp
        ll.front = temp
        ll.end = temp
        ll.curr = temp
        ll.add_node(2)
        ll.add_node(1)
        ll.curr = ll.curr.prev
        elf = 3
        total_elves = int(inp[0])
        for i in range(3, part[1] + 1):
            if elf > total_elves:
                elf = 1
            if i % 23 == 0:
                score[elf] += i
                for k in range(0, 7):
                    ll.curr = ll.curr.prev
                score[elf] += ll.curr.value
                ll.curr.prev.nex = ll.curr.nex
                ll.curr.nex.prev = ll.curr.prev
                ll.curr = ll.curr.nex
                ll.length -= 1
            else:
                ll.curr = ll.curr.nex
                ll.add_node(i)
            elf += 1
        # print(score) # Dictionary Of All Scores!!
        maxim = (0, 0)
        for k, v in score.items():
            if v > maxim[1]:
                maxim = (k, v)
        print(part[0], maxim)

if __name__ == '__main__':
    main()
    