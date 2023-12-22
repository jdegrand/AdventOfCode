require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def recursion(curr, steps_remaining, board, evens, visited, dp)
    return if dp[curr] && dp[curr] >= steps_remaining
    evens << curr if steps_remaining.even?
    if steps_remaining == 0
        return
    end
    neighbors = [[-1, 0], [1, 0], [0, -1], [0, 1]].map{ |dr, dc| [curr.first + dr, curr.last + dc] }
    neighbors.filter!{ |r, c|
        r >= 0 && r < board.length && c >= 0 && c < board[0].length && !(board[r][c] == ?#) && !visited.include?([r, c]) && (dp[[r, c]] || 0) < steps_remaining 
    }
    neighbors.each{ |next_pos|
        visited << next_pos
        recursion(next_pos, steps_remaining - 1, board, evens, visited, dp)
        visited.delete(next_pos)
    }
    dp[curr] = [dp[curr] || 0, steps_remaining].max
end

def day21_1
    board = []
    start = nil
    $lines.each{|l| board << l.chars}
    board.each_with_index{|l, r| l.each_with_index{|ch, c| start = [r, c] if ch == ?S}}
    evens = Set.new
    visited = Set.new
    dp = {}
    recursion(start, 64, board, evens, visited, dp)
    evens.size
end

def recursion2(curr, steps_remaining, board, evens, visited, dp)
    return if dp[curr] && dp[curr] >= steps_remaining
    evens << curr if steps_remaining.even?
    if steps_remaining == 0
        return
    end
    neighbors = [[-1, 0], [1, 0], [0, -1], [0, 1]].map{ |dr, dc| [curr.first + dr, curr.last + dc] }
    neighbors.filter!{ |r, c|
        !(board[r % board.length][c % board[0].length] == ?#) && !visited.include?([r, c]) && (dp[[r, c]] || 0) < steps_remaining 
    }
    neighbors.each{ |next_pos|
        visited << next_pos
        recursion2(next_pos, steps_remaining - 1, board, evens, visited, dp)
        visited.delete(next_pos)
    }
    dp[curr] = [dp[curr] || 0, steps_remaining].max
end

def maximum_border(curr, steps_remaining, board, evens, visited, dp)
    return if dp[curr] && dp[curr] >= steps_remaining
    evens << curr if steps_remaining.even?
    if steps_remaining == 0
        return
    end
    neighbors = [[-1, 0], [1, 0], [0, -1], [0, 1]].map{ |dr, dc| [curr.first + dr, curr.last + dc] }
    neighbors.filter!{ |r, c|
        !(board[r][c] == ?#) && !visited.include?([r, c]) && (dp[[r, c]] || 0) < steps_remaining 
    }
    neighbors.each{ |next_pos|
        visited << next_pos
        recursion2(next_pos, steps_remaining - 1, board, evens, visited, dp)
        visited.delete(next_pos)
    }
    dp[curr] = [dp[curr] || 0, steps_remaining].max
end

def day21_2
    board = []
    start = nil
    $lines.each{|l| board << l.chars}
    board.each_with_index{|l, r| l.each_with_index{|ch, c| start = [r, c] if ch == ?S}}
    evens = Set.new
    visited = Set.new
    dp = {}
    maximum_border(start, 500, board, evens, visited, dp)
    evens.size
end

# pp day21_1
pp day21_2
