require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

class Cube
    def initialize(x, y, z)
        @sides = 
            [
                Set.new([[x, y, z], [x, y + 1, z], [x, y + 1, z + 1], [x, y, z + 1]]),
                Set.new([[x + 1, y, z], [x + 1, y + 1, z], [x + 1, y + 1, z + 1], [x + 1, y, z + 1]]),
                Set.new([[x, y, z], [x + 1, y, z], [x + 1, y, z + 1], [x, y, z + 1]]),
                Set.new([[x, y + 1, z], [x + 1, y + 1, z], [x + 1, y + 1, z + 1], [x, y + 1, z + 1]]),
                Set.new([[x, y, z], [x + 1, y, z], [x + 1, y + 1, z], [x, y + 1, z]]),
                Set.new([[x, y, z + 1], [x + 1, y, z + 1], [x + 1, y + 1, z + 1], [x, y + 1, z + 1]])
            ]
    end

    attr_accessor :sides
end

def day18_1
    cubes = Hash.new(0)
    $lines.each do |l|
        px, py, pz = l.split(?,).map(&:to_i)
        Cube.new(px, py, pz).sides.each{|side| cubes[side] += 1}
    end
    cubes.filter{|_, v| v == 1}.size
end

def day18_2
    cubes = Hash.new(0)
    solid_cubes = Set.new()
    tests = nil
    min = [Float::INFINITY, Float::INFINITY, Float::INFINITY]
    max = [-Float::INFINITY, -Float::INFINITY, -Float::INFINITY]
    $lines.each do |l|
        px, py, pz = l.split(?,).map(&:to_i)
        solid_cubes << [px, py, pz]
        Cube.new(px, py, pz).sides.each{|side| cubes[side] += 1}
        min = min.zip([px, py, pz]).map(&:min)
        max = max.zip([px, py, pz]).map(&:max)
    end

    min = min.map{|point| point - 1}
    max = max.map{|point| point + 1}

    all_cubes = Set.new
    air_cubes = Set.new
    (min[0]..max[0]).each do |x|
        (min[1]..max[1]).each do |y|
            (min[2]..max[2]).each do |z|
                if !solid_cubes.include?([x, y, z])
                    air_cubes << [x, y, z]
                end
                all_cubes << [x, y, z]
            end
        end
    end

    queue = [min]
    visited = Set.new([queue[0]])
    until queue.empty?
        curr = queue.shift
        [[-1, 0, 0], [1, 0, 0], [0, -1, 0], [0, 1, 0], [0, 0, -1], [0, 0, 1]].map{|dx, dy, dz| [curr[0] + dx, curr[1] + dy, curr[2] + dz]}.filter{|coord| air_cubes.include?(coord) && !visited.include?(coord)}.each do |coord|
            visited << coord
            queue << coord
        end
    end

    unreached_sides = Set.new
    (all_cubes - visited - solid_cubes).each{|(px, py, pz)| Cube.new(px, py, pz).sides.each{|side| unreached_sides << side if cubes.has_key?(side)}}
    cubes.filter{|_, v| v == 1}.size - unreached_sides.length
end

pp day18_1
pp day18_2
