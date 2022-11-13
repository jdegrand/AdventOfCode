require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day12_helper(start, pipes)
    connected = Set.new
    queue = pipes[start].to_a
    until queue.empty?
        curr = queue.pop
        connected << curr
        pipes[curr].each do |c|
            queue << c unless connected === c
        end
    end
    connected
end

def day12_1
    pipes = {} 
    $lines.each do |l|
        key, _, *connections = l.split
        connections = connections.join(" ")
        pipes[key] = Set.new(connections.split(", "))
    end
    pipes.freeze

    day12_helper(?0, pipes).size
end

def day12_2
    pipes = {} 
    $lines.each do |l|
        key, _, *connections = l.split
        connections = connections.join(" ")
        pipes[key] = Set.new(connections.split(", "))
    end
    pipes.freeze

    groups = 0
    all_visited = Set.new()
    pipes.keys.each do |k|
        unless all_visited === k
            new_visited = day12_helper(k, pipes)
            groups += 1
            all_visited.merge(new_visited)
        end
    end

    groups
end

pp day12_1
pp day12_2
