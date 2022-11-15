require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day15_1
    a = $lines[0].split[-1].to_i
    b = $lines[1].split[-1].to_i

    a_factor = 16807
    b_factor = 48271
    divisor = 2147483647

    max_num = ((2 ** 16) - 1)
    matching = 0
    40000000.times do
        a = (a * a_factor) % divisor
        b = (b * b_factor) % divisor
        matching += 1 if a & max_num == b & max_num
    end
    matching
end

def day15_2
    a = $lines[0].split[-1].to_i
    b = $lines[1].split[-1].to_i

    a_factor = 16807
    b_factor = 48271
    divisor = 2147483647
    
    max_num = ((2 ** 16) - 1)

    a_nums = []
    b_nums = []

    while a_nums.length != 5000000
        a = (a * a_factor) % divisor
        a_nums << a if a % 4 == 0
    end

    while b_nums.length != 5000000
        b = (b * b_factor) % divisor
        b_nums << b if b % 8 == 0
    end

    a_nums.zip(b_nums).count{|la, lb| la & max_num == lb & max_num}
end

pp day15_1
pp day15_2
