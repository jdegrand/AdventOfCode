file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day1_1
    floor = 0
    $lines[0].each_char{|c| floor += c == '(' ? 1 : -1 }
    floor
end

def day1_2
    floor = 0
    $lines[0].each_char.with_index do |c, i|
        floor += c == '(' ? 1 : -1
        return i + 1 if floor == -1
    end
end

pp day1_1
pp day1_2
