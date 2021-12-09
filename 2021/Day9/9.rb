require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day9_1
    points = Hash.new(Float::INFINITY)
    adj = [[0,1],[1,0],[0, -1], [-1,0]]
    $lines.each_with_index do |l, r|
        l.chars.each_with_index do |p, c|
            points[[r, c]] = p.to_i
        end
    end
    risk = 0
    points.each do |k, v|
        risk += (v + 1) if adj.filter{|dx, dy| points[[k[0] + dx, k[1] + dy]] <= v}.length == 0
    end
    risk
end

def dfs(points, r, c, v)
    stack = []
    visited = Set.new
    count = 1
    adj = [[0, 1], [1, 0], [0, -1], [-1, 0]]
    stack << [r,c] if v != 9 
    visited << [r,c] 
    until stack.length == 0
        cr, cc = stack.shift
        adj.each do |dx, dy|
            if points[[cr + dx, cc + dy]] <= v && !visited.include?([cr + dx, cc + dy])
                count += 1
                visited << [cr + dx, cc + dy]
                stack << [cr + dx, cc + dy]
            end
        end
    end
    visited
end

def day9_2
    points = Hash.new(Float::INFINITY)
    adj = [[0, 1], [1, 0], [0, -1], [-1, 0]]
    $lines.each_with_index do |l, r|
        l.chars.each_with_index do |p, c|
            points[[r, c]] = p.to_i
        end
    end
    basins = Set.new
    points.each do |k, v|
        basins << dfs(points, k[0], k[1], v)
    end
    basins.map{|b| b.length}.sort[-3..].reduce(:*)
end

pp day9_1
pp day9_2
