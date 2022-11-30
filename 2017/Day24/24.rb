require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def backtracking(port, ports, visited, current_score, max, length, longest_max)
    to_check = ports[port].each.reject do |po|
        p1, p2 = [port, po].sort!
        visited.include?("#{p1}/#{p2}")
    end
    if to_check.size == 0
        max[0] = [max[0], current_score].max
        longest_max[0] = [longest_max[0], [length, current_score]].max
    end
    to_check.each do |po|
        p1, p2 = [port, po].sort!
        str = "#{p1}/#{p2}"
        visited << str
        backtracking(po, ports, visited, current_score + port + po, max, length + 1, longest_max)
        visited.delete(str)
    end
end

def day24
    ports = Hash.new([])
    $lines.each do |l|
        left, right = l.split(?/)
        ports[left.to_i] += [right.to_i]
        ports[right.to_i] += [left.to_i] unless left == right
    end
    visited = Set.new
    max = [0]
    longest_max = [[0, 0]]
    backtracking(0, ports, visited, 0, max, 0, longest_max)
    pp max.first
    pp longest_max.first.last
end

day24
