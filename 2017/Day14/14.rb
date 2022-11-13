require "../util/knot_hash.rb"
require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day14_1
    inp = $lines[0]
    grid = {}
    (0...128).each do |n|
        num = ?f
        knot = KnotHash.new("#{inp}-#{n}").hash
        grid[n] = knot.chars.map{|h| h.hex.to_s(2).rjust(4, ?0)}.join
    end
    grid.values.join.count(?1)
end

def day14_2
    inp = $lines[0]
    grid = Hash.new(0)
    (0...128).each do |row|
        num = ?f
        knot = KnotHash.new("#{inp}-#{row}").hash
        knot.chars.each_with_index{|h, i| h.hex.to_s(2).rjust(4, ?0).chars.each_with_index{|b, si| grid[[row, (i * 4) + si]] = b.to_i}}
    end

    to_visit = Set.new(grid.filter{|_, v| v == 1}.keys)
    regions = 0
    until to_visit.empty?
        queue = [to_visit.first]
        until queue.empty?
            curr = queue.pop
            to_visit.delete(curr)
            [[0, -1], [0, 1], [-1, 0], [1, 0]].each do |dr, dc|
                queue << [curr[0] + dr, curr[1] + dc] if to_visit === [curr[0] + dr, curr[1] + dc]
            end
        end
        regions += 1
    end
    regions
end

pp day14_1
pp day14_2
