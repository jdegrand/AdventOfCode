file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def print_board(board, rows, cols)
    rows.times do |r|
        s = ""
        cols.times do |c|
            s += board[[r, c]]
        end
        puts s
    end
end

def day25_1
    board = {}
    east = []
    south = []

    $lines.each_with_index do |l, i|
        l.chars.each_with_index do |chr, j|
            east << [i, j] if chr == ?>
            south << [i, j] if chr == ?v
            board[[i, j]] = chr
        end
    end

    rows = $lines.length
    cols = $lines[0].length

    steps = 1
    while true
        moved = 0
        east_board = board.clone
        next_east = []
        east.each do |r, c|
            to_move = [r, (c + 1) % cols]
            if board[to_move] == ?.
                east_board[to_move] = ?>
                east_board[[r, c]] = ?.
                next_east << to_move
                moved += 1
            else
                next_east << [r, c]
            end
        end
        south_board = east_board.clone
        next_south = []
        south.each do |r, c|
            to_move = [(r + 1) % rows, c]
            if east_board[to_move] == ?.
                south_board[to_move] = ?v
                south_board[[r, c]] = ?.
                next_south << to_move
                moved += 1
            else
                next_south << [r, c]
            end
        end
        break if moved == 0
        board = south_board
        east = next_east
        south = next_south
        steps += 1
    end
    steps
end

def day25_2
    puts "Sleigh keys found and the sleigh was started remotley with 50 stars!"
    puts "Merry Christmas!"
end

pp day25_1
day25_2
