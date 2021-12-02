file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day2_1
    v = 0
    h = 0
    $lines.each do |l|
        d, i = l.split
        i = i.to_i
        case d
        when "forward"
            h += i
        when "down"
            v += i
        when "up"
            v -= i
        end
    end
    v * h
end

def day2_2
    v = 0
    h = 0
    aim = 0
    $lines.each do |l|
        d, i = l.split
        i = i.to_i
        case d
        when "forward"
            h += i
            v += (aim * i)
        when "down"
            aim += i
        when "up"
            aim -= i
        end
    end
    v * h
end

pp day2_1
pp day2_2

