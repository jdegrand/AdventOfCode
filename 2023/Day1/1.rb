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

def day1_2_alternate
    overlapping = $nums.permutation(2).to_a.filter{|s1, s2| s1[-1] === s2[0]}.map{|s1, s2| [s1 + s2[1..], s1 + s2]}
    $lines.map do |l|
        new_line = l
        overlapping.each{|over, sep| new_line = new_line.gsub(over, sep)}
        numbers = new_line.scan(/one|two|three|four|five|six|seven|eight|nine|\d/)
        [get_num(numbers[0]), numbers.length == 1  ? get_num(numbers[0]) : get_num(numbers[-1]) ].join.to_i
    end.sum
end

pp day1_1
pp day1_2
