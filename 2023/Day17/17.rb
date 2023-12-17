require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def backtracking(curr, current_score, dir, dir_count, visited, minimum, goal, board)
    # pp curr
    # sleep(0.1)
    return if dir_count >= 3
    if curr == goal
        old_min = minimum[0]
        minimum = [[minimum[0], current_score].min]
        pp minimum if minimum[0] != old_min
        return
    end
    paths = [[0, -1], [0, 1], [-1, 0], [1, 0]].reject do |dr, dc| 
        nr, nc = curr.first + dr, curr.last + dc
        visited.include?([[nr, nc]]) || nr < 0 || nc < 0 || nr >= board.length || nc >= board[0].length
    end
    paths.each do |dr, dc|
        next_pos = [curr.first + dr, curr.last + dc]
        visited << [next_pos]
        backtracking(next_pos, current_score + board[curr.first][curr.last].to_i, [dr, dc], [dr, dc] == dir ? dir_count + 1 : 0, visited, minimum, goal, board)
        visited.delete([next_pos])
    end
end

def day17_1
    minimum = [Float::INFINITY]
    board = $lines.map(&:freeze).freeze
    pp board
    goal = [board.length - 1, board[-1].length - 1]
    visited = Hash.new(0)
    backtracking([0, 0], 0, [0, 0], 0, visited, minimum, goal, board)
    minimum
end

def day17_2
end

pp day17_1
pp day17_2
