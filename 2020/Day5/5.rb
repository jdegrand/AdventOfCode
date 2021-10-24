file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day5_1
    return $lines.map { |l|
        row_code = l[0...-3]
        col_code = l[-3..]
        min, max = 0, 127
        row_code.chars.each do |c|
            min, max = c == "F" ? [min, max - (max-min)/2 - 1] : [max - (max-min)/2, max]
        end
        minc, maxc = 0, 7
        col_code.chars.each do |c|
            minc, maxc = c == "L" ? [minc, maxc - (maxc-minc)/2 - 1] : [maxc - (maxc-minc)/2, maxc]
        end
        min * 8 + minc
    }
end

def day5_2
    seats = day5_1
    min, max = seats.min, seats.max
    (min..max).to_a - seats
end

puts day5_1.max
puts day5_2

