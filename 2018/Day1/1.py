"""
@author: Joe DeGrand
Advent Of Code 2018 Day 1: Frequency Problem
"""

def main():
    """
    Main function in charge of the looping of the program
    """
    total = 0
    dic = {}
    dic[0] = True
    first = True
    frequency = 0
    loop = True
    while first is not False:
        for line in open("input.txt"):
            line = line.strip()
            operator = line[0]
            value = int(line[1:])
            if operator == "-":
                total -= value
            else:
                total += value
            if total in dic.keys() and first is True:
                print("First Repeated Frequency: " + str(total))
                first = False
            elif first is False:
                pass
            else:
                dic[total] = True
        if loop is True:
            frequency = total
            loop = False
    print("Total frequency is: " + str(frequency))

if __name__ == '__main__':
    main()
