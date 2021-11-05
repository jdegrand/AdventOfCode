file = 'input.txt'
input = File.read(file)

$lines = input.split("\n").map(&:to_i)

def day10_1
    adapters = $lines.sort
    diff = []
    last = 0
    adapters.each do |a|
        curr = a - last
        diff << curr
        last = a
    end
    (diff.count(3)+1)*diff.count(1)
end

def day10_2
    adapters = $lines.sort
    adapters << (adapters[-1] + 3)
    memo = Hash[(0..adapters[-1]).map { |num| [num, 0] }]
    memo[1] = adapters.include?(1) ? 1 : 0
    memo[2] = adapters.include?(2) ? memo[1] + 1 : 0
    memo[3] = adapters.include?(3) ? memo[1] + memo[2] + 1 : 0
    adapters = adapters - [1] - [2] - [3]
    adapters.each do |a|
        memo[a] = memo[a-1] + memo[a-2] + memo[a-3]
    end
    return memo[adapters[-1]]
end

puts day10_1
puts day10_2

