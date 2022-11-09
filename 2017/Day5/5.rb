file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day5_1
    nums = $lines.map(&:to_i)
    index = 0
    steps = 0
    while index < nums.length
        new_index = index + nums[index]
        nums[index] += 1
        index = new_index
        steps += 1
    end
    steps
end

def day5_2
    nums = $lines.map(&:to_i)
    index = 0
    steps = 0
    while index < nums.length
        new_index = index + nums[index]
        nums[index] += nums[index] >= 3 ? -1 : 1
        index = new_index
        steps += 1
    end
    steps
end

pp day5_1
pp day5_2
