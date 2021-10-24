require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n").map(&:chomp)

def day6_1
    $lines.map { |l|
        s = Set.new
        l.split("\n").each do |e|
            e.chars.each {|c| s << c}
        end
        s.length
    }.reduce(:+)
end

def day6_2
    $lines.map { |l|
        sets = []
        l.split("\n").each do |e|
            s = Set.new
            e.chars.each {|c| s << c}
            sets << s
        end
        sets.reduce(:&).length
    }.reduce(:+)
end

puts day6_1
puts day6_2

