require 'set'
file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day14_1
    dish = {}
    rows = $lines.length
    cols = $lines[0].length
    $lines[0].chars.each_with_index{ dish[[0, _2]] = _1}
    $lines[1..].each_with_index { |l, r|
        r += 1
        l.chars.each_with_index{ |ch, c|
            dish[[r, c]] = ?.
            if ch == ?O
                r.downto(1).each {|ri|
                    if dish[[ri - 1, c]] != ?. 
                        dish[[ri, c]] = ?O
                        break
                    elsif ri - 1 == 0
                        dish[[0, c]] = ?O
                    end
                }
            else
                dish[[r, c]] = ch
            end
        }
    }
    (rows - 1).downto(0).each_with_index.map{|row, index|
        (0...cols).map{|col| dish[[row, col]]}.count(?O) * (index + 1)
    }.sum
end

def cycle(board, rows, cols)
    dish = board
    # For some reason my code gets the same results even if i don't do North, West, South, and East
    # It works if I only do North
    4.times {
        (1...rows).each { |r|
            (0...cols).each { |c|
                ch = dish[r][c]
                if ch == ?O
                    r.downto(1).each {|ri|
                        if dish[ri - 1][c] != ?. 
                            dish[ri][c] = ?O
                            break
                        elsif ri - 1 == 0
                            dish[0][c] = ?O
                            dish[ri][c] = ?.
                        else
                            dish[ri][c] = ?.
                        end
                    }
                else
                    dish[r][c] = ch
                end
            }
        }
        dish = dish.transpose.map(&:reverse)
    }
    return dish
end

def cycle(board, rows, cols)
    dish = board
    4.times {
        (1...rows).each { |r|
            (0...cols).each { |c|
                ch = dish[r][c]
                if ch == ?O
                    r.downto(1).each {|ri|
                        if dish[ri - 1][c] != ?. 
                            dish[ri][c] = ?O
                            break
                        elsif ri - 1 == 0
                            dish[0][c] = ?O
                            dish[ri][c] = ?.
                        else
                            dish[ri][c] = ?.
                        end
                    }
                else
                    dish[r][c] = ch
                end
            }
        }
        dish = dish.transpose.map(&:reverse)
    }
    return dish
end

def day14_2
    dish = []
    $lines.each_with_index{ |l, r|
        dish << l.chars
    }
    rows = $lines.length
    cols = $lines[0].length

    total_cycles = 1000000000
    seen_positions = Set.new
    position_to_cycle = {}
    north_loads = {}

    repeating_position, repeating_cycle = total_cycles.times { |cyc|
        dish = cycle(dish, rows, cols)
        north_load = (rows - 1).downto(0).each_with_index.map{|row, index|
            (0...cols).map{|col| dish[row][col]}.count(?O) * (index + 1)
        }.sum

        north_loads[cyc + 1] = north_load
        current_position = []
        
        dish.each_with_index{|r, ri| r.each_with_index{|ch, ci| current_position << [ri, ci] if ch == ?O }}
        break [current_position, cyc + 1] if seen_positions.include?(current_position)

        seen_positions << current_position
        position_to_cycle[current_position] = cyc + 1
    }

    start_loop = position_to_cycle[repeating_position]
    end_loop = repeating_cycle - 1
    cycle_length = repeating_cycle - start_loop
    cycles_before_loop = start_loop - 1

    north_loads[cycles_before_loop + ((total_cycles - cycles_before_loop) % cycle_length)]    
end

def print_board(board, r, c)
    (0...r).each { |cr|
        pp (0...c).map { |cc|
            board[[cr, cc]]
        }.join
    }
end

def print_board_array(board, r)
    (0...r).each { |cr|
        pp board[cr].join
    }
end

pp day14_1
pp day14_2
