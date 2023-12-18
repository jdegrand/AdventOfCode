require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day18_1
    ground = Hash.new(?.)
    vertices = Set.new

    dirs = {
        ?L => [0, -1],
        ?R => [0, 1],
        ?U => [-1, 0],
        ?D => [1, 0],
    }.freeze

    r, c = 0, 0
    vertices << [r, c]
    ground[[r, c]] = ?#

    $lines.each{ |l|
        dir, n, _ = l.split
        n = n.to_i
        dr, dc = dirs[dir]

        n.times {
            r += dr
            c += dc
            ground[[r, c]] = ?#
        }
        vertices << [r, c]
    }

    xs = vertices.map(&:first)
    ys = vertices.map(&:last)

    # Shoelace Formula
    area = (xs.zip(ys.rotate).map{|x, y| x * y}.sum - ys.zip(xs.rotate).map{|x, y| x * y}.sum).abs / 2.0

    # Pick's Theorem
    area + (ground.count{ _2 == ?# } / 2.0) + 1
end

def day18_2
    vertices = Set.new

    dirs = {
        ?0 => [0, 1],  # R
        ?1 => [1, 0],  # D
        ?2 => [0, -1], # L
        ?3 => [-1, 0], # U
    }.freeze

    r, c = 0, 0
    border_count = 0
    vertices << [r, c]

    $lines.each{ |l|
        _, _, hex = l.split
        dir = hex[-2]
        n = hex[2...-2].to_i(16)
        dr, dc = dirs[dir]

        border_count += n
        r += (n * dr)
        c += (n * dc)
 
        vertices << [r, c]
    }

    xs = vertices.map(&:first)
    ys = vertices.map(&:last)

    # Shoelace Formula
    area = (xs.zip(ys.rotate).map{|x, y| x * y}.sum - ys.zip(xs.rotate).map{|x, y| x * y}.sum).abs / 2.0

    # Pick's Theorem
    area + (border_count / 2.0) + 1
end

pp day18_1
pp day18_2
