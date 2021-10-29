require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.chomp.split(",").map(&:to_i)

def day15_1(num)
    nums = $lines
    mem = Hash.new([])
    turn = 1
    last = -1
    nums.length.times do |i|
        mem[nums[i]] += [turn]
        turn += 1
        last = nums[i]
    end
    while turn <= num
        if mem[last].length == 1
            mem[nums[0]] += [turn]
            last = 0
        else
            last = mem[last][-1] - mem[last][-2]
            mem[last] += [turn]
        end
        turn += 1
    end
    last
end

def day15_2(num)
    nums = $lines
    mem = Hash.new([])
    turn = 1
    last = -1
    nums.length.times do |i|
        mem[nums[i]] = [turn]
        turn += 1
        last = nums[i]
    end
    while turn <= num
        if mem[last].length == 1
            mem[nums[0]] = [mem[nums[0]][-1], turn]
            last = 0 
        else
            last = mem[last][-1] - mem[last][-2]
            mem[last] = mem[last].length == 0 ? [turn] : [mem[last][-1], turn]
        end
        turn += 1
    end
    last
end


puts day15_1(2020)
puts day15_2(30000000)

