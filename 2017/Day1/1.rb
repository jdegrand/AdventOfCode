file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day1_1
    digits = $lines[0].chars.map(&:to_i)
    sum = 0
    (1...digits.length).each do |i|
        sum += digits[i] if digits[i - 1] == digits[i]
    end
    sum += digits[0] if digits[0] == digits[-1]
    sum
end

def day1_2
    digits = $lines[0].chars.map(&:to_i)
    sum = 0
    halfway = digits.length / 2
    (0...digits.length).each do |i|
        sum += digits[i] if digits[i] == digits[(i + halfway) % digits.length]
    end
    sum
end

pp day1_1
pp day1_2
