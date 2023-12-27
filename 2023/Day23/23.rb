require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

$slopes = {
    [-1, 0] => ?^,
    [1, 0] => ?v,
    [0, -1] => ?<,
    [0, 1] => ?>
}

def backtracking(curr, current_steps, visited, board, steps)
    if curr == [board.length - 1, board[0].length - 2]
        steps << current_steps
        return
    end
    to_check = [[-1, 0], [1, 0], [0, -1], [0, 1]].filter{|dr, dc|
        in_bounds = (curr.first + dr) >= 0 && (curr.first + dr) < board.length && (curr.last + dc) >= 0 && (curr.last + dc) < board[0].length
        next_pos = [curr.first + dr, curr.last + dc]
        next_ch = board[next_pos.first][next_pos.last]
        valid_move = next_ch == ?. || next_ch == $slopes[[dr, dc]]
        in_bounds && valid_move && !visited.include?(next_pos)
    }.map{ [curr.first + _1, curr.last + _2] }

    to_check.each do |next_pos|
        visited << next_pos
        backtracking(next_pos, current_steps + 1, visited, board, steps)
        visited.delete(next_pos)
    end
end

def day23_1
    board = $lines.map{|l| l.chars}

    start = [0, 1]

    steps = Set.new
    visited = Set.new

    backtracking(start, 0, visited, board, steps)

    steps.max
end

def backtracking2(curr, current_steps, visited, nodes, steps, goal)
    if curr == goal
        steps << current_steps
        return
    end
    to_check = nodes[curr].reject{|next_pos, _| visited.include?(next_pos)}

    to_check.each do |next_pos, add_steps|
        visited << next_pos
        backtracking2(next_pos, current_steps + add_steps, visited, nodes, steps, goal)
        visited.delete(next_pos)
    end
end

def day23_2
    board = $lines.map{|l| l.chars}

    start = [0, 1]

    steps = Set.new
    visited = Set.new

    nodes = Hash.new([])

    visited << start

    queue = [[start, start, 0, visited]]

    until queue.empty?
        curr, last_inter, current_steps, visited = queue.shift

        if curr == [board.length - 1, board[0].length - 2]
            nodes[last_inter] += [[curr, current_steps]]
        end

        neighbors = [[-1, 0], [1, 0], [0, -1], [0, 1]].filter{|dr, dc|
            (curr.first + dr) >= 0 && (curr.first + dr) < board.length && (curr.last + dc) >= 0 && (curr.last + dc) < board[0].length
        }.filter{ |dr, dc|
            next_pos = [curr.first + dr, curr.last + dc]
            next_ch = board[next_pos.first][next_pos.last]
            valid_move = next_ch != ?#
            valid_move && !visited.include?(next_pos) && !nodes[last_inter].include?([curr, current_steps])
        }.map{ [_1 + curr.first, _2 + curr.last] }
        if neighbors.length > 1
            nodes[last_inter] += [[curr, current_steps]]
            neighbors.each{ |n|
                visited << n
                queue << [n, curr, 1, Set.new([curr, n])]
            }
        else
            neighbors.each{ |n|
                visited << n
                queue << [n, last_inter, current_steps + 1, visited]
            } 
        end
    end

    steps = Set.new
    visited = Set.new
    goal = [board.length - 1, board[0].length - 2]

    backtracking2(start, 0, visited, nodes, steps, goal)

    steps.max
end

pp day23_1
pp day23_2
