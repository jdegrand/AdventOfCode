file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n")

def day1_1
    $lines.map{|elf| elf.lines.map(&:chomp).map(&:to_i).sum}.max
end

def day1_2
    $lines.map{|elf| elf.lines.map(&:chomp).map(&:to_i).sum}.sort[-3..].sum
end

pp day1_1
pp day1_2
