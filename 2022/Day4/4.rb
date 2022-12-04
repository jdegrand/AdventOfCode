file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day4_1
    $lines.count do |l|
        l_range, r_range = l.split(?,)
        left, right = l_range.split(?-).map(&:to_i), r_range.split(?-).map(&:to_i)
        (left[0] >= right[0] && left[1] <= right[1]) || (left[0] <= right[0] && left[1] >= right[1])
    end
end

def day4_2
    $lines.count do |l|
        l_range, r_range = l.split(?,)
        left, right = l_range.split(?-).map(&:to_i), r_range.split(?-).map(&:to_i)
        ((left[0]..left[1]).to_a & (right[0]..right[1]).to_a).length > 0
    end
end

pp day4_1
pp day4_2
