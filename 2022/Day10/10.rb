require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day10_1
    x = 1
    to_add = Set.new([20, 60, 100, 140, 180, 220])
    cycles = []
    $lines.each_with_index do |l, i|
        left, right = l.split
        if left == "addx"
            cycles << 0
            cycles << right.to_i
        else
            cycles << 0
        end
    end

    sum = 0
    cycles.each_with_index do |c, i|
        sum += (x * (i + 1)) if to_add.include?(i + 1)
        x += c
    end
    sum
end

def day10_2
    x = 1
    to_add = Set.new([20, 60, 100, 140, 180, 220])
    cycles = []
    $lines.each_with_index do |l, i|
        left, right = l.split
        if left == "addx"
            cycles << 0
            cycles << right.to_i
        else
            cycles << 0
        end
    end

    crt = ""
    cycles.each_with_index do |c, oi|
        i = oi % 40
        crt += [i - 1, i, i + 1].include?(x) ? ?# : ?.
        x += c
    end

    crt.chars.each_slice(40){|slice| puts slice.join}
end

pp day10_1
day10_2
