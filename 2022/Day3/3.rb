file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day3_1
    ($lines.map do |l|
        left = l[0...(l.length / 2)].chars
        right = l[(l.length / 2)..].chars
        common = (left & right).first
        common.match(/[a-z]/) ? common.ord - 96 : common.ord - 38
    end).sum
end

def day3_2
    ($lines.each_slice(3).map do |elves|
        common = elves.map(&:chars).inject(:&).first
        common.match(/[a-z]/) ? common.ord - 96 : common.ord - 38
    end).sum
end

pp day3_1
pp day3_2
