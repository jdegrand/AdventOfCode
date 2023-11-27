require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

$dirs = {
    ?^ => [1, 0],
    ?> => [0, 1],
    ?v => [-1, 0],
    ?< => [0, -1]
}

def day3_1
    location = [0, 0]
    visited = Set.new([location])
    $lines[0].each_char do |c|
        location = location.zip($dirs[c]).map{|pair| pair.sum}
        visited << location
    end
    visited.count
end

def day3_2
    s = [0, 0]
    rs = [0, 0]
    visited = Set.new([s])
    $lines[0].each_char.with_index do |c, i|
        if i % 2 == 0
            s = s.zip($dirs[c]).map{|pair| pair.sum}
            visited << s
        else
            rs = rs.zip($dirs[c]).map{|pair| pair.sum}
            visited << rs
        end
    end
    visited.count
end

pp day3_1
pp day3_2
