file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day8_1
    dirs = $lines[0]
    nodes = {}
    $lines[2..].each { |l|
        node, left, right = l.scan(/[A-Z]+/)
        nodes[node] = [left, right]
    }
    curr = "AAA"
    steps = dir_ind = 0
    until curr == "ZZZ"
        dir = dirs[dir_ind % dirs.length]
        curr = dir == ?L ? nodes[curr].first : nodes[curr].last
        steps += 1
        dir_ind += 1
    end
    steps
end

def day8_2
    dirs = $lines[0]
    nodes = {}
    $lines[2..].each { |l|
        node, left, right = l.scan(/[A-Z]+/)
        nodes[node] = [left, right]
    }
    curr = nodes.keys.filter{|n| n[-1] == ?A}
    curr.map{ |c|
        steps = dir_ind = 0
        until c[-1] == ?Z
            dir = dirs[dir_ind % dirs.length]
            c = dir == ?L ? nodes[c].first : nodes[c].last
            steps += 1
            dir_ind += 1
        end
        steps
    }.inject(1, :lcm)
end

pp day8_1
pp day8_2
