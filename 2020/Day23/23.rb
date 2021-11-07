require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day23_1
    cups = $lines[0].chars.map(&:to_i)
    min, max = cups.minmax
    100.times do |i|
        index = i % cups.length
        current = cups[index]
        dest = current == min ? max : current - 1
        pickup = []
        if index >= cups.length - 3
            pickup += cups[(index + 1)..] + cups[0..(3 - (cups.length - index))]
        else
            pickup = cups[(index + 1)..(index + 3)]
        end
        while pickup.include?(dest)
            dest = dest == min ? max : dest - 1
        end
        pickup.map{|c| cups.delete(c)}
        new_cups = []
        curr_index = cups.index(current)
        (curr_index...(cups.length + curr_index)).each do |j|
            new_cups << cups[j % cups.length]
            if cups[j % cups.length] == dest then new_cups += pickup end
        end
        cups = new_cups.rotate(-index)
    end
    cups.map(&:to_s).join.split("1").reverse.join
end

def day23_2
    cups = $lines[0].chars.map(&:to_i)
    min, max = cups.minmax
    cups += (max+1..1000000).to_a
    max = 1000000
    100.times do |i|
        index = i % cups.length
        current = cups[index]
        dest = current == min ? max : current - 1
        pickup = []
        if index >= cups.length - 3
            pickup += cups[(index + 1)..] + cups[0..(3 - (cups.length - index))]
        else
            pickup = cups[(index + 1)..(index + 3)]
        end
        while pickup.include?(dest)
            dest = dest == min ? max : dest - 1
        end
        pickup.map{|c| cups.delete(c)}
        new_cups = []
        curr_index = cups.index(current)
        (curr_index...(cups.length + curr_index)).each do |j|
            new_cups << cups[j % cups.length]
            if cups[j % cups.length] == dest then new_cups += pickup end
        end
        cups = new_cups.rotate(-index)
    end
    cups.map(&:to_s).join.split("1").reverse.join
end

puts day23_1
puts day23_2

