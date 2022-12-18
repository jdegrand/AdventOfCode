require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)


class Cube
    def initialize(x, y, z)
        sides = 
            [[[x, y, z], [x, y + 1, z], [x, y + 1, z + 1], [x, y, z + 1]],
            [[x + 1, y, z], [x + 1, y + 1, z], [x + 1, y + 1, z + z], [x + 1, y, z + 1]],
            [[x, y, z], [x + 1, y, z], [x + 1, y, z + 1], [x, y, z + 1]],
            [[x, y + 1, z], [x + 1, y + 1, z], [x + 1, y + 1, z + 1], [x, y + 1, z + 1]],
            [[x, y, z], [x + 1, y, z], [x + 1, y + 1, z], [x, y + 1, z]],
            [[x, y, z + 1], [x + 1, y, z + 1], [x + 1, y + 1, z + 1], [x, y + 1, z + 1]]
            ]
    end
    
end

def day18_1
    x = Hash.new(0)
    y = Hash.new(0)
    z = Hash.new(0)
    $lines.each do |l|
        px, py, pz = l.split(?,).map(&:to_i)
        x[[px, [0, 1].product([0,1]).map{|d1, d2| [py + d1, pz + d2]}]] += 1
        x[[px + 1, [0, 1].product([0,1]).map{|d1, d2| [py + d1, pz + d2]}]] += 1
        y[[py, [0, 1].product([0,1]).map{|d1, d2| [pz + d1, px + d2]}]] += 1
        y[[py + 1, [0, 1].product([0,1]).map{|d1, d2| [pz + d1, px + d2]}]] += 1
        z[[pz, [0, 1].product([0,1]).map{|d1, d2| [px + d1, py + d2]}]] += 1
        z[[pz + 1, [0, 1].product([0,1]).map{|d1, d2| [px + d1, py + d2]}]] += 1
    end
    x.filter{|_, v| v == 1}.size + y.filter{|_, v| v == 1}.size + z.filter{|_, v| v == 1}.size
end

def day18_2
    cubes = Set.new
    x = Hash.new(0)
    y = Hash.new(0)
    z = Hash.new(0)
    min = [Float::INFINITY, Float::INFINITY, Float::INFINITY]
    max = [-Float::INFINITY, -Float::INFINITY, -Float::INFINITY]
    $lines.each do |l|
        px, py, pz = l.split(?,).map(&:to_i)
        x[[px, [0, 1].product([0,1]).map{|d1, d2| [py + d1, pz + d2]}]] += 1
        x[[px + 1, [0, 1].product([0,1]).map{|d1, d2| [py + d1, pz + d2]}]] += 1
        y[[py, [0, 1].product([0,1]).map{|d1, d2| [pz + d1, px + d2]}]] += 1
        y[[py + 1, [0, 1].product([0,1]).map{|d1, d2| [pz + d1, px + d2]}]] += 1
        z[[pz, [0, 1].product([0,1]).map{|d1, d2| [px + d1, py + d2]}]] += 1
        z[[pz + 1, [0, 1].product([0,1]).map{|d1, d2| [px + d1, py + d2]}]] += 1
        min = [[min[0], px].min, [min[1], py].min, [min[2], pz].min]
        max = [[max[0], px].max, [max[1], py].max, [max[2], pz].max]
    end
    queue = []
    min = [min[0] - 1, min[1] - 1, min[2] - 1]
    max = [max[0] - 1, max[1] - 1, max[2] - 1]

    visited = Set.new
    queue << min
    until queue.empty?
        px, py, pz = queue.shift

    end



    count = 0
    covered_sides = Set.new
    pp x, y, z
    $lines.each do |l|
        px, py, pz = l.split(?,).map(&:to_i)
        sides = [[px, [0, 1].product([0,1]).map{|d1, d2| [py + d1, pz + d2]}],
                 [px + 1, [0, 1].product([0,1]).map{|d1, d2| [py + d1, pz + d2]}],
                 [py, [0, 1].product([0,1]).map{|d1, d2| [pz + d1, px + d2]}],
                 [py + 1, [0, 1].product([0,1]).map{|d1, d2| [pz + d1, px + d2]}],
                 [pz, [0, 1].product([0,1]).map{|d1, d2| [px + d1, py + d2]}],
                 [pz + 1, [0, 1].product([0,1]).map{|d1, d2| [px + d1, py + d2]}]]
        all_covered = [x[sides[0]] > 1,
                       x[sides[1]] > 1,
                       y[sides[2]] > 1,
                       y[sides[3]] > 1,
                       z[sides[4]] > 1,
                       z[sides[5]] > 1].all?
        if all_covered
            pp [px, py, pz]
            sides.each_with_index do |s, i|
                if i == 0 || i == 1
                    covered_sides << [?x, s]
                elsif i == 2 || i == 3
                    covered_sides << [?y, s]
                else
                    covered_sides << [?z, s]
                end
            end
        end
    end
    # 2158

    #low
    # 1079
    x.filter{|_, v| v == 1}.size + y.filter{|_, v| v == 1}.size + z.filter{|_, v| v == 1}.size - (covered_sides.size)
end

pp day18_1
pp day18_2
