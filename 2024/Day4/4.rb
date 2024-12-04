require "set"

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

# BFS done but not needed. I way overcomplicated this...
def day4_1
    search = Hash.new(?.)
    $lines.each_with_index{ |l, i|
        l.chars.each_with_index{ |c, j|
            search[[i, j]] = c
        }
    }
    xs = search.filter{ |k, v| v == ?X }

    steps = Hash.new(false)
    steps.merge!({
        ?X => ?M,
        ?M => ?A,
        ?A => ?S
    })

    dirs = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]
    xs.reduce(0){ |v, (coord, _)|
        matches = 0
        dirs.each{ |dx, dy|
            visited = Set.new
            queue = [coord]
            until queue.empty?
                curr = queue.pop
                visited << curr
                val = search[curr]
                x, y = curr
                if val == ?S
                    matches += 1
                    next
                end
                next_coord = [x + dx, y + dy]
                queue << next_coord if search[next_coord] == steps[val] && !visited.include?(next_coord)
            end
        }
        v + matches
    }
end

def day4_2
    search = Hash.new(?.)
    $lines.each_with_index{ |l, i|
        l.chars.each_with_index{ |c, j|
            search[[i, j]] = c
        }
    }
    xs = search.filter{ |k, v| v == ?M || v == ?S }

    xs.reduce(0){ |v, (coord, _)|
        x, y = coord
        valid = Set.new(%w(SAM MAS))
        first_coords = [coord, [x + 1, y + 1], [x + 2, y + 2]]
        second_coords = [[x, y + 2], [x + 1, y + 1], [x + 2, y]]
        x_shape = [first_coords, second_coords].all?{ | coord_set | valid.include?(coord_set.map{ |new_coord| search[new_coord] }.join) }
        x_shape ? v + 1 : v
    }
end

pp day4_1
pp day4_2
