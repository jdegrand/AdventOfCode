require 'set'

file = "input.txt"
input = File.read(file)

$nums = input.split("\n").map(&:to_i)

def day1_1
    s = Set.new
    $nums.each do |n|
        if s.include?(2020 - n)
            puts  n * (2020 - n)
            return
        end
        s << n
    end
end

def day1_2
    (0...$nums.length).each do |i|
        s = Set.new
        ((i+1)...$nums.length).each do |n|
            if s.include?(2020 - $nums[n] - $nums[i])
                puts $nums[n] * (2020 - $nums[n] - $nums[i]) * $nums[i]
                return
            end
            s << $nums[n]
        end
    end
end

day1_1
day1_2
