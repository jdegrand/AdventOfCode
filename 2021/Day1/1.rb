file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp).map(&:to_i)

def day1_1
    bigger = 0
    $lines[1..].each_with_index do |l, i|
        bigger += 1 if $lines[i] < l
    end
    bigger
end

def day1_2
    bigger = 0
    wind = [$lines[0], $lines[1], $lines[2]]
    last = 3
    while last < $lines.length
        prev = wind.sum
        wind.shift
        wind << $lines[last]
        csum = wind.sum
        bigger += 1 if prev < csum
        last += 1
    end
    bigger
end

pp day1_1
pp day1_2

