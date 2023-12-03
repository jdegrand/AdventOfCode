require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day3_1
    schematic = Hash.new(?.)
    $lines.each_with_index do |l, r|
        l.chars.each_with_index do |ch, c|
            schematic[[r, c]] = ch
        end
    end
    sum = 0  
    $lines.each_with_index do |l, r|
        l.scan(/\d+/) do |n|
            start_index, end_index = Regexp.last_match.offset(0)
            surrounding_sym = (start_index...end_index).map do |c|
                [-1, 0, 1].product([-1, 0, 1]).map do |dr, dc|
                    !(schematic[[r + dr, c + dc]] =~ /(\.|\d)/)
                end.any?
            end.any?
            sum += n.to_i if surrounding_sym
        end
    end
    sum
end

def day3_2
    nums = {}
    $lines.each_with_index do |l, r|
        l.scan(/\d+/) do |n|
            start_index, end_index = Regexp.last_match.offset(0)
            nums[[r, (start_index...end_index)]] = n.to_i
        end
    end
    ratios = []
    $lines.each_with_index do |l, r|
        l.scan(/\*/) do |_|
            gear = Regexp.last_match.offset(0)[0]
            parts = Set.new
            [-1, 0, 1].product([-1, 0, 1]).each do |dr, dc|
                part = nums.select{|(kr, kc), _| kr == (r + dr) && kc.cover?(gear + dc)}
                part.values.each{|v| parts << v}
            end
            ratios << parts.inject(:*) if parts.length == 2
        end
    end
    ratios.sum
end

pp day3_1
pp day3_2
