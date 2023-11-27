file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day2_1
    $lines.map do |l|
        l, w, h = l.split(?x).map(&:to_i)
        areas = [l * w, w * h, h * l]
        areas.map{|a| a * 2}.sum + areas.min
    end.sum
end

def day2_2
    $lines.map do |l|
        l, w, h = l.split(?x).map(&:to_i)
        smallest_perimeter = [l + w, w + h, h + l].map{|i| i * 2}.min
        smallest_perimeter + l*w*h
    end.sum
end

pp day2_1
pp day2_2
