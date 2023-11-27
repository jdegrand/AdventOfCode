require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

$vowels = Set.new("aeiou".chars).freeze

def day5_1
    vowels = /(a|e|i|o|u)/
    double_letters = /(.)\1/
    not_allowed = /(ab|cd|pq|xy)/
    nice = 0
    $lines.each do |l|
        nice += 1 if l.scan(vowels).length >= 3 && l =~ double_letters && !(l =~ not_allowed)
    end
    nice
end

def day5_2
    nice = 0
    $lines.each do |l|
        doubles = Hash.new
        is_doubles = false
        l.chars.each_cons(2).each_with_index do |(c1, c2), i|
            seq = [c1,c2].join
            if doubles.key?(seq) && doubles[seq] != i - 1
                is_doubles = true
                break
            end
            doubles[seq] = i if !doubles.key?(seq)
        end
        is_repeating = false
        l.chars.each_cons(3) do |c1, _, c2|
            if c1 == c2
                is_repeating = true
                break
            end
        end
        nice += 1 if is_doubles && is_repeating
    end
    nice
end

pp day5_1
pp day5_2
