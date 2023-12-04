require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day4_1
    $lines.map do |l|
        winning_nums, my_nums = l.gsub(/Card +\d+: /, "").split(" | ").map{ _1.split.map(&:to_i)}
        matching = Set.new(winning_nums) & Set.new(my_nums)
        points = matching.size == 0 ? 0 : 1
        (matching.size - 1).times{points *= 2} 
        points
    end.sum
end

def day4_2
    cards_counts = {}
    $lines.length.times{ cards_counts[_1 + 1]= 1 }
    $lines.each.with_index do |l, i|
        card = i + 1
        winning_nums, my_nums = l.gsub(/Card +\d+: /, "").split(" | ").map{ _1.split.map(&:to_i)}
        matching = Set.new(winning_nums) & Set.new(my_nums)
        ((card + 1)...(card + 1 + matching.size)).each do |ind|
            cards_counts[ind] += cards_counts[card] if cards_counts[ind]
        end 
    end
    cards_counts.values.sum
end

pp day4_1
pp day4_2
