file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day7_1
    grid = {}
    curr = nil
    $lines.each_with_index{ |l, r|
        l.chars.each_with_index{ |ch, c|
            grid[[r, c]] = ch
            curr = [r, c] if ch == ?S
        }
    }
    rows = $lines.length
    cols = $lines[0].length
    queue = [curr]
    visited = Set.new(curr)
    splits = Set.new
    until queue.empty?
        r, c = queue.shift
        next_row = r + 1
        if next_row < rows
            if grid[[next_row, c]] == ?^
                splits << [next_row, c]
                [c - 1, c + 1].filter{ _1 >= 0 && _1 < cols && !visited.include?([next_row, _1])}.each{ |next_col|
                    next_node = [next_row, next_col]
                    visited << next_node 
                    queue << next_node
                }
            else
                next_node = [next_row, c]
                visited << next_node
                queue << next_node
            end
        end
    end
    splits.size
end

def day7_2
    grid = {}
    memo = Hash.new(0)
    curr = nil
    $lines.each_with_index{ |l, r|
        l.chars.each_with_index{ |ch, c|
            grid[[r, c]] = ch
            curr = [r, c] if ch == ?S
        }
    }
    rows = $lines.length
    cols = $lines[0].length

    memo[curr] = 1
    queue = [curr]
    until queue.empty?
        r, c = queue.shift
        next_row = r + 1
        if next_row < rows
            if grid[[next_row, c]] == ?^
                [c - 1, c + 1].filter{ _1 >= 0 && _1 < cols}.each{ |next_col|
                    next_node = [next_row, next_col]
                    memo[next_node] += memo[[r, c]]
                    queue << next_node
                }
            else
                next_node = [next_row, c]
                memo[next_node] = memo[[r, c]]
                queue << next_node
            end
        end
    end
    memo.values.max
end

pp day7_1
pp day7_2
