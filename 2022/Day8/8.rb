file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day8_1
    trees = Hash.new(-1)
    $lines.each_with_index do |r, ri|
        r.chars.each_with_index do |c, ci|
            trees[[ci, ri]] = c.to_i
        end
    end
    trees.freeze
    num_rows = $lines.length
    num_cols = $lines[0].length
    trees.count do |(ci, ri), v|
        [[*(-1...ci)].product([ri]), [*((ci + 1)..num_cols)].product([ri]), [ci].product([*(-1...ri)]), [ci].product([*((ri + 1)..num_rows)])].any? do |coords|
            coords.all?{|coord| trees[coord] < v}
        end
    end
end

def day8_2
    trees = Hash.new(-1)
    $lines.each_with_index do |r, ri|
        r.chars.each_with_index do |c, ci|
            trees[[ci, ri]] = c.to_i
        end
    end
    trees.freeze
    num_rows = $lines.length
    num_cols = $lines[0].length
    (trees.map do |(ci, ri), v|
        ([[-1, 0], [1, 0], [0, -1], [0, 1]].map do |dx, dy|
            trees_seen = 0
            last_seen = -2
            coord = [ci, ri]
            while last_seen < v
                coord = [coord[0] + dx, coord[1] + dy]
                last_seen = trees[coord]
                trees_seen += 1 if last_seen > -1
                break if last_seen == -1
            end
            trees_seen
        end).inject(:*)
    end).max
end

pp day8_1
pp day8_2
