"""
[1518-07-18 23:57] Guard #157 begins shift
[1518-04-18 00:44] wakes up
[1518-10-26 00:20] falls asleep
[1518-10-12 00:32] falls asleep
[1518-04-12 00:03] Guard #2857 begins shift
[1518-08-14 23:52] Guard #331 begins shift
[1518-05-19 00:01] Guard #1801 begins shift
[1518-09-22 00:52] wakes up
[1518-07-03 00:32] wakes up
[1518-11-08 00:40] falls asleep
[1518-01-23 00:19] falls asleep
[1518-05-03 00:43] wakes up
[1518-07-04 00:54] wakes up
          |
                    |
"""

def compare(i):
    i = i.split(' ')
    i = ' '.join(i[0:2]).strip("[]").split(' ')
    date = i[0].split('-')
    time = i[1].split(':')
    year = int(date[0])
    month = int(date[1])
    day = int(date[2])
    hour = int(time[0])
    minute = int(time[1])
    return hour, minute, year, month, day

def compare2(i):
    if i.split()[3].strip("#").isdigit():
        return int(i.split()[3].strip("#"))
    else:
        return 0

def main():
    ls = []
    for line in open("input.txt"):
        ls += [line.strip()]
    ls.sort(key=lambda x: compare2(x))
    for item in ls:
        print(item)

if __name__ == '__main__':
    main()
