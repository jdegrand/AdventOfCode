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
    second_board = Hash.new(?.)
    energies = Set.new
    beams = [[[0, -1], [0, 1]]]
    until beams.empty?
        coord, dir = beams.shift
        energies << [coord, dir] if coord != [0, -1]
        second_board[coord] = ?# if coord != [0, -1]
        next_coord = [coord.first + dir.first, coord.last + dir.last]
        if board.key?(next_coord) && !energies.include?([next_coord, dir])
            case board[next_coord]
            when ?.
                beams << [next_coord, dir]
            when ?|
                if dir.last != 0
                    beams << [next_coord, [-1, 0]]
                    beams << [next_coord, [1, 0]]
                else
                    beams << [next_coord, dir]
                end
            when ?-
                if dir.first != 0
                    beams << [next_coord, [0, -1]]
                    beams << [next_coord, [0, 1]]
                else
                    beams << [next_coord, dir]
                end
            when ?/
                beams << [next_coord, [1, 0]] if dir == [0, -1]
                beams << [next_coord, [-1, 0]] if dir == [0, 1]
                beams << [next_coord, [0, 1]] if dir == [-1, 0]
                beams << [next_coord, [0, -1]] if dir == [1, 0]
            when '\\'
                beams << [next_coord, [-1, 0]] if dir == [0, -1]
                beams << [next_coord, [1, 0]] if dir == [0, 1]
                beams << [next_coord, [0, -1]] if dir == [-1, 0]
                beams << [next_coord, [0, 1]] if dir == [1, 0]
            else
                raise "Character not mapped..."
            end 
        end
    end
    print_board(second_board)
    energies.map(&:first).uniq.size
end

def day16_2
end

pp day16_1
pp day16_2
