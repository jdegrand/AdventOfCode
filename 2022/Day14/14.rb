file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day14_1
    grid = Hash.new(?.)
    max_r = 0
    $lines.each do |l|
        rock_lines = l.split(" -> ")
        rock_lines.each_cons(2) do |r1, r2|
            r1_c, r1_r = r1.split(?,).map(&:to_i)
            r2_c, r2_r = r2.split(?,).map(&:to_i)
            sorted_rocks = [[r1_r, r1_c], [r2_r, r2_c]].sort
            (sorted_rocks[0][0]..sorted_rocks[1][0]).each do |r|
                (sorted_rocks[0][1]..sorted_rocks[1][1]).each do |c|
                    grid[[r, c]] = ?#
                    max_r = r if r > max_r
                end
            end
        end
    end

    sand_grains = 0
    while true
        sand_pos = [0, 500]
        while next_pos = [[1, 0], [1, -1], [1, 1]].map{|dr, dc| [sand_pos[0] + dr, sand_pos[1] + dc]}.detect{|coord| grid[coord] == ?.}
            sand_pos = next_pos
            return sand_grains if sand_pos[0] == max_r + 1
        end
        grid[sand_pos] = ?O
        sand_grains += 1
    end
end

def day14_2
    grid = Hash.new(?.)
    max_r = 0
    $lines.each do |l|
        rock_lines = l.split(" -> ")
        rock_lines.each_cons(2) do |r1, r2|
            r1_c, r1_r = r1.split(?,).map(&:to_i)
            r2_c, r2_r = r2.split(?,).map(&:to_i)
            sorted_rocks = [[r1_r, r1_c], [r2_r, r2_c]].sort
            (sorted_rocks[0][0]..sorted_rocks[1][0]).each do |r|
                (sorted_rocks[0][1]..sorted_rocks[1][1]).each do |c|
                    grid[[r, c]] = ?#
                    max_r = r if r > max_r
                end
            end
        end
    end

    ((500 - max_r - 4)..(500 + max_r + 4)).each{|lc| grid[[max_r + 2, lc]] = ?#}

    sand_grains = 0
    while true
        sand_pos = [0, 500]
        while next_pos = [[1, 0], [1, -1], [1, 1]].map{|dr, dc| [sand_pos[0] + dr, sand_pos[1] + dc]}.detect{|coord| grid[coord] == ?.}
            sand_pos = next_pos
        end
        grid[sand_pos] = ?O
        sand_grains += 1
        return sand_grains if sand_pos == [0, 500]
    end
end

pp day14_1
pp day14_2
