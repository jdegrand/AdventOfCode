require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def backtack(curr, steps, visited, grid, ways, mins)
    ways << steps if grid[curr] == ?|
    mins[curr] = steps

    [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |dx, dy|
        coord = [curr[0] + dx, curr[1] + dy]
        if !visited.include?(coord) && mins[coord] > steps + 1 && ((grid[coord].ord <= (grid[curr].ord + 1)) ||  (grid[curr] == ?z && grid[coord] == ?|))
            visited << coord
            backtack(coord, steps + 1, visited, grid, ways, mins)
            visited.delete(coord)
        end
    end
end

def day12_1
    grid = Hash.new(?~)
    start = nil
    goal = nil
    $lines.each_with_index do |l, ri|
        l.chars.each_with_index do |c, ci|
            grid[[ri, ci]] = c
            start = [ri, ci] if c == ?S
            goal = [ri, ci] if c == ?E
        end
    end

    grid[start] = ?a
    grid[goal] = ?|

    visited = Set.new
    mins = Hash.new(Float::INFINITY)
    ways = []

    backtack(start, 0, visited, grid, ways, mins)
    
    ways.min
end

def day12_2
    grid = Hash.new(?~)
    starts = []
    goal = nil
    $lines.each_with_index do |l, ri|
        l.chars.each_with_index do |c, ci|
            grid[[ri, ci]] = c
            if c == ?S
                grid[[ri, ci]] = ?a
                starts << [ri, ci]
            elsif c == ?a
                starts << [ri, ci]
            end
            goal = [ri, ci] if c == ?E
        end
    end

    grid[goal] = ?|

    visited = Set.new
    mins = Hash.new(Float::INFINITY)
    ways = []
    starts.each{|start| backtack(start, 0, visited, grid, ways, mins)}
    
    ways.min
end

pp day12_1
pp day12_2
