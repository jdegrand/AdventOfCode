require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def print_board(board)
(0...$lines.length).each {|r|
        l = ''
        (0...$lines[0].length).each {|c|
            l << board[[r, c]]
        }
        pp l
    }
end

def day16_1
    board = {}
    $lines.each_with_index { |l, r|
        l.chars.each_with_index{ |ch, c| board[[r, c]] = ch}
    }
    board.freeze
    energies = Set.new
    beams = [[[0, -1], [0, 1]]]
    until beams.empty?
        coord, dir = beams.shift
        energies << [coord, dir]
        next_coord = [coord.first + dir.first, coord.last + dir.last]
        if board.key?(next_coord)
            pending_beams = []
            case board[next_coord]
            when ?.
                pending_beams << [next_coord, dir]
            when ?|
                if dir.last != 0
                    pending_beams << [next_coord, [-1, 0]]
                    pending_beams << [next_coord, [1, 0]]
                else
                    pending_beams << [next_coord, dir]
                end
            when ?-
                if dir.first != 0
                    pending_beams << [next_coord, [0, -1]]
                    pending_beams << [next_coord, [0, 1]]
                else
                    pending_beams << [next_coord, dir]
                end
            when ?/
                pending_beams << [next_coord, [1, 0]] if dir == [0, -1]
                pending_beams << [next_coord, [-1, 0]] if dir == [0, 1]
                pending_beams << [next_coord, [0, 1]] if dir == [-1, 0]
                pending_beams << [next_coord, [0, -1]] if dir == [1, 0]
            when '\\'
                pending_beams << [next_coord, [-1, 0]] if dir == [0, -1]
                pending_beams << [next_coord, [1, 0]] if dir == [0, 1]
                pending_beams << [next_coord, [0, -1]] if dir == [-1, 0]
                pending_beams << [next_coord, [0, 1]] if dir == [1, 0]
            else
                raise "Character not mapped..."
            end 
            energies << [coord, dir]
            pending_beams.each{|beam|
                beams << beam if !energies.include?(beam)
            }
        end
    end
    energies.map(&:first).uniq.size - 1
end

def day16_2
    board = {}
    $lines.each_with_index { |l, r|
        l.chars.each_with_index{ |ch, c| board[[r, c]] = ch}
    }
    board.freeze
    starting_beams = []
    (0...$lines[0].length).each{|c| starting_beams << [[-1, c], [1, 0]]}
    (0...$lines[0].length).each{|c| starting_beams << [[$lines.length, c], [-1, 0]]}
    (0...$lines.length).each{|r| starting_beams << [[r, -1], [0, 1]]}
    (0...$lines.length).each{|r| starting_beams << [[r, $lines[0].length], [0, -1]]}
    starting_beams.map{|starting_beam|
        energies = Set.new
        beams = [starting_beam]
        until beams.empty?
            coord, dir = beams.shift
            energies << [coord, dir]
            next_coord = [coord.first + dir.first, coord.last + dir.last]
            if board.key?(next_coord)
                pending_beams = []
                case board[next_coord]
                when ?.
                    pending_beams << [next_coord, dir]
                when ?|
                    if dir.last != 0
                        pending_beams << [next_coord, [-1, 0]]
                        pending_beams << [next_coord, [1, 0]]
                    else
                        pending_beams << [next_coord, dir]
                    end
                when ?-
                    if dir.first != 0
                        pending_beams << [next_coord, [0, -1]]
                        pending_beams << [next_coord, [0, 1]]
                    else
                        pending_beams << [next_coord, dir]
                    end
                when ?/
                    pending_beams << [next_coord, [1, 0]] if dir == [0, -1]
                    pending_beams << [next_coord, [-1, 0]] if dir == [0, 1]
                    pending_beams << [next_coord, [0, 1]] if dir == [-1, 0]
                    pending_beams << [next_coord, [0, -1]] if dir == [1, 0]
                when '\\'
                    pending_beams << [next_coord, [-1, 0]] if dir == [0, -1]
                    pending_beams << [next_coord, [1, 0]] if dir == [0, 1]
                    pending_beams << [next_coord, [0, -1]] if dir == [-1, 0]
                    pending_beams << [next_coord, [0, 1]] if dir == [1, 0]
                else
                    raise "Character not mapped..."
                end 
                energies << [coord, dir]
                pending_beams.each{|beam|
                    beams << beam if !energies.include?(beam)
                }
            end
        end
        energies.map(&:first).uniq.size - 1
    }.max
end

pp day16_1
pp day16_2
