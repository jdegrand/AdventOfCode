require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day10_1
    neighbors_away = {
        ?| => [[-1, 0], [1, 0]], 
        ?- => [[0, 1], [0, -1]],
        ?L => [[-1, 0], [0, 1]],
        ?J => [[-1, 0], [0, -1]],
        ?7 => [[1, 0], [0, -1]],
        ?F => [[1, 0], [0, 1]],
        ?. => [[0, 0]]
    }
    neighbors_to = {}
    neighbors_away.each{|k, v| neighbors_to[k] = v.map{|dr, dc| [-dr, -dc]}}
    maze = Hash.new(?.)
    $lines.each_with_index{ |l, r|
        l.chars.each_with_index { |ch, c|
            maze[[r, c]] = ch
        }
    }
    s = maze.find{ _2 == ?S}.first
    start_pipes = [[-1, 0], [1, 0], [0, -1], [0, 1]].map{|dr, dc| [[s.first + dr, s.last + dc], [dr, dc]]}.filter{ neighbors_to[maze[_1]].include?(_2)}.map(&:first)
    curr = start_pipes.first
    visited = Set.new([s, curr])
    until curr == start_pipes.last
        curr = neighbors_away[maze[curr]].map{|dr, dc| [curr.first + dr, curr.last + dc]}.filter{ !visited.include?(_1) }.first
        visited << curr
    end
    [visited.length / 2, visited]
end

def day10_2(visited)
    maze = Hash.new(?.)
    $lines.each_with_index{ |l, r|
        l.chars.each_with_index { |ch, c|
            maze[[r, c]] = ch
        }
    }
    neighbors_away = {
        ?| => [[-1, 0], [1, 0]], 
        ?- => [[0, 1], [0, -1]],
        ?L => [[-1, 0], [0, 1]],
        ?J => [[-1, 0], [0, -1]],
        ?7 => [[1, 0], [0, -1]],
        ?F => [[1, 0], [0, 1]],
        ?. => [[0, 0]]
    }
    neighbors_to = {}
    neighbors_away.each{|k, v| neighbors_to[k] = v.map{|dr, dc| [-dr, -dc]}}
    s_to_pipe = {
        Set.new([[0, -1], [-1, 0]]) => ?J,
        Set.new([[0, -1], [0, 1]]) => ?-,
        Set.new([[0, -1], [1, 0]]) => ?7,
        Set.new([[0, 1], [-1, 0]]) => ?L,
        Set.new([[0, 1], [1, 0]]) => ?F,
        Set.new([[-1, 0], [1, 0]]) => ?|,
    }

    s = maze.find{ _2 == ?S}.first
    start_diffs = [[-1, 0], [1, 0], [0, -1], [0, 1]].map{|dr, dc| [[s.first + dr, s.last + dc], [dr, dc]]}.filter{ neighbors_to[maze[_1]].include?(_2)}.map(&:last)

    # Replace S with character it should be
    s_replacement = s_to_pipe[Set.new(start_diffs)]

    $lines.map.with_index { |l, r|
        count = 0
        last_bend = nil
        bends = [?F, ?J, ?L, ?7, ?S]
        in_loop = 0
        l.chars.each_with_index{|ch, c| 
            if visited.include?([r, c])
                ch = s_replacement if ch == ?S
                if ch == ?-
                elsif last_bend
                    if last_bend == ?S && (ch == ?F || ch == ?L)
                        in_loop = in_loop === 0 ? 1 : 0
                        last_bend = ch
                    else
                        if [[?F, ?7], [?L, ?J], [?S, ?7], [?S, ?J], [?F, ?S], [?L, ?S]].include?([last_bend, ch])
                            in_loop = in_loop === 0 ? 1 : 0
                        end
                        last_bend = nil
                    end
                else
                    if bends.include?(ch)
                        in_loop = in_loop === 0 ? 1 : 0
                        last_bend = ch
                    elsif ch == ?|
                        in_loop = in_loop === 0 ? 1 : 0
                    end
                end
            else
                count += in_loop 
            end
        }
        count
    }.sum
end

# Solution implementing Shoelace Formula and Pick's Theorem after looking at other's on Reddit
def day10_3(visited)
    maze = Hash.new(?.)
    $lines.each_with_index{ |l, r|
        l.chars.each_with_index { |ch, c|
            maze[[r, c]] = ch
        }
    }
    neighbors_away = {
        ?| => [[-1, 0], [1, 0]], 
        ?- => [[0, 1], [0, -1]],
        ?L => [[-1, 0], [0, 1]],
        ?J => [[-1, 0], [0, -1]],
        ?7 => [[1, 0], [0, -1]],
        ?F => [[1, 0], [0, 1]],
        ?. => [[0, 0]]
    }
    neighbors_to = {}
    neighbors_away.each{|k, v| neighbors_to[k] = v.map{|dr, dc| [-dr, -dc]}}
    s_to_pipe = {
        Set.new([[0, -1], [-1, 0]]) => ?J,
        Set.new([[0, -1], [0, 1]]) => ?-,
        Set.new([[0, -1], [1, 0]]) => ?7,
        Set.new([[0, 1], [-1, 0]]) => ?L,
        Set.new([[0, 1], [1, 0]]) => ?F,
        Set.new([[-1, 0], [1, 0]]) => ?|,
    }

    s = maze.find{ _2 == ?S}.first
    start_diffs = [[-1, 0], [1, 0], [0, -1], [0, 1]].map{|dr, dc| [[s.first + dr, s.last + dc], [dr, dc]]}.filter{ neighbors_to[maze[_1]].include?(_2)}.map(&:last)

    # Replace S with character it should be
    s_replacement = s_to_pipe[Set.new(start_diffs)]
    maze[s] = s_replacement
    all_coords = visited.to_a.filter{|coord| [?L, ?F, ?J, ?7].include?(maze[coord])}
    xs = all_coords.map(&:first)
    ys = all_coords.map(&:last)

    # Shoelace Formula
    area = (xs.zip(ys.rotate).map{|x, y| x * y}.sum - ys.zip(xs.rotate).map{|x, y| x * y}.sum).abs / 2.0
    
    # Pick's Theorem
    area + 1 - (visited.length / 2.0) 
end

$part1, visited = day10_1
$part2 = day10_2(visited)
$part3 = day10_3(visited)

pp $part1
pp $part2
