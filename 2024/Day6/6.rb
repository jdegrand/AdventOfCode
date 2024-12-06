require "set"

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day6_1
    grid = Hash.new(?-)
    curr = [-1, -1]
    $lines.each_with_index { |l, i| 
        l.chars.each_with_index { |c, j|
            grid[[i, j]] = c
            curr = [i, j] if c == ?^
        }
    }

    dir = [-1, 0]
    dirs = {
        [-1, 0] => [0, 1],
        [0, 1] => [1, 0],
        [1, 0] => [0, -1],
        [0, -1] => [-1, 0]
    }
    visited = Set.new
    until grid[curr] == ?-
        visited << curr
        nex = curr.zip(dir).map(&:sum)
        if grid[nex] == ?#
            dir = dirs[dir]
        else
            curr = nex
        end
    end
    visited.size
end

def day6_2
    grid = Hash.new(?-)
    curr = [-1, -1]
    $lines.each_with_index { |l, i| 
        l.chars.each_with_index { |c, j|
            grid[[i, j]] = c
            curr = [i, j] if c == ?^
        }
    }

    start = curr
    dir = [-1, 0]
    dirs = {
        [-1, 0] => [0, 1],
        [0, 1] => [1, 0],
        [1, 0] => [0, -1],
        [0, -1] => [-1, 0]
    }

    visited = Set.new
    until grid[curr] == ?-
        visited << curr
        nex = [curr[0] + dir[0], curr[1] + dir[1]]
        if grid[nex] == ?#
            dir = dirs[dir]
        else
            curr = nex
        end
    end

    possible = visited.delete(start)
    possible.reduce(0) { |v, coord| 
        grid[coord] = ?#
        is_loop = false
        visited = Set.new
        curr = start
        dir = [-1, 0]
        until grid[curr] == ?-
            if visited.include?([curr, dir])
                is_loop = true
                break
            end
            visited << [curr, dir]
            nex = curr.zip(dir).map(&:sum)
            if grid[nex] == ?#
                dir = dirs[dir]
            else
                curr = nex
            end
        end

        grid[coord] = ?.
        is_loop ? v + 1 : v
    }
end

pp day6_1
pp day6_2
