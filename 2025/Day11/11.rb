require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day11_1
    tree = Hash.new([])
    $lines.each{ |l|
        root, children = l.split(": ")
        children = children.split
        tree[root] = children
    }

    curr = "you"
    visited = Set.new([curr])
    queue = [[curr, curr]]
    until queue.empty?
        curr, curr_path = queue.shift
        tree[curr].each{ |node|
            next_path = "#{curr_path}->#{node}"
            if !visited.include?(next_path)
                visited << next_path
                queue << [node, next_path]
            end
        }
    end
    visited.count{ _1.split("->").last == "out" }
end

def day11_2
    tree = Hash.new([])
    $lines.each{ |l|
        root, children = l.split(": ")
        children = children.split
        tree[root] = children
    }

    curr = "svr"
    visited = Set.new([curr])
    queue = [[curr, curr]]
    dp = {}
    until queue.empty?
        curr, curr_path = queue.shift
        tree[curr].each{ |node|
            next_path = "#{curr_path}->#{node}"
            if !visited.include?(next_path)
                visited << next_path
                queue << [node, next_path]
            end
        }
    end
    visited.count{ |path|
        nodes = path.split("->")
        nodes.last == "out" && nodes.include?("dac") && nodes.include?("fft")
    }
end

pp day11_1
pp day11_2
