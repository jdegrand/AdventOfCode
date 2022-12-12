require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def backtack(curr, steps, visited, grid, ways)
    ways << steps if grid[curr] == ?|

    [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |dx, dy|
        coord = [curr[0] + dx, curr[1] + dy]
        if !visited.include?(coord) && ((grid[coord].ord <= (grid[curr].ord + 1)) ||  (grid[curr] == ?z && grid[coord] == ?|))
            visited << coord
            backtack(coord, steps + 1, visited, grid, ways)
            visited.delete(coord)
        end
    end
end

def day12_1
    grid = Hash.new(?~)
    start = nil
    en = nil
    $lines.each_with_index do |l, ri|
        l.chars.each_with_index do |c, ci|
            grid[[ri, ci]] = c
            start = [ri, ci] if c == ?S
            en = [ri, ci] if c == ?E
        end
    end
    visited = Set.new
    queue = []
    queue << [start, 0]
    grid[start] = ?a
    grid[en] = ?|
    ways = []
    visited << start
    # backtack(start, 0, visited, grid, ways)
    until queue.empty?
        curr, steps = queue.shift
        ways << steps if grid[curr] == ?|
        return steps if grid[curr] == ?|
        visited << curr
        to_visit = []
        [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |dx, dy|
            coord = [curr[0] + dx, curr[1] + dy]
            to_visit << [coord, steps + 1] if !visited.include?(coord) && ((grid[coord].ord <= (grid[curr].ord + 1)) ||  (grid[curr] == ?z && grid[coord] == ?|))
        end
        to_visit.sort{|coord, _| (grid[curr].ord + 1) - grid[coord].ord}.each{|coord| queue << coord}
    end
    pp ways.min
end

def day12_2
end

pp day12_1
pp day12_2
