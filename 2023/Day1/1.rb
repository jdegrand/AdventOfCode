file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day1_1
    $lines.map do |l|
        numbers = l.chars.filter{|c| c =~ /\d/}
        [numbers[0], numbers.length == 1  ? numbers[0] : numbers[-1] ].join.to_i
    end.sum
end

$nums = %W(one two three four five six seven eight nine)
$nums_to_digits = {}
$nums.each.with_index{|n, i| $nums_to_digits[n] = "#{i + 1}"}

def get_num(c)
    return c =~ /\d/ ? c : $nums_to_digits[c]
end

def day1_2
    $lines.map do |l|
        numbers =  l.scan(/(?=(one|two|three|four|five|six|seven|eight|nine|\d))/).flatten
        [get_num(numbers[0]), numbers.length == 1  ? get_num(numbers[0]) : get_num(numbers[-1]) ].join.to_i
    end.sum
end

pp day1_1
pp day1_2
