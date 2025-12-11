file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day4_1
    grid = Hash.new(?.)
    rows = $lines.length
    cols = $lines[0].length
    $lines.each_with_index{ |l, r|
        l.chars.each_with_index{ |ch, c| grid[[r, c]] = ch}
    }
    neighbors = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]
    (0...rows).sum{ |ri|
        (0...cols).count{ |ci|
            grid[[ri, ci]] == ?@ && neighbors.count{ |dr, dc| grid[[ri + dr, ci + dc]] == ?@ } < 4
        }
    }    
end

def day4_2
    grid = Hash.new(?.)
    rows = $lines.length
    cols = $lines[0].length
    $lines.each_with_index{ |l, r|
        l.chars.each_with_index{ |ch, c| grid[[r, c]] = ch}
    }
    neighbors = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]
    total_removed = 0
    can_remove = true
    while can_remove
        next_grid = grid.clone
        local_removed = 0
        (0...rows).each{ |ri|
            (0...cols).each{ |ci|
                if grid[[ri, ci]] == ?@ && neighbors.count{ |dr, dc| grid[[ri + dr, ci + dc]] == ?@ } < 4
                    next_grid[[ri, ci]] = ?.
                    local_removed += 1
                end
            }
        }
        grid = next_grid
        total_removed += local_removed
        can_remove = false if local_removed == 0
    end
    total_removed
end

pp day4_1
pp day4_2
