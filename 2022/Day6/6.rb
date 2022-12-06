file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day6_1
    chars = $lines[0].chars
    (3...chars.length).each do |i|
        return i + 1 if (chars[(i - 3)..i]).uniq == chars[(i - 3)..i]
    end
end

def day6_2
    chars = $lines[0].chars
    (13...chars.length).each do |i|
        return i + 1 if (chars[(i - 13)..i]).uniq == chars[(i - 13)..i]
    end
end

pp day6_1
pp day6_2
