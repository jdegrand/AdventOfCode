file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n")

def rotate(times)
    to_rotate = File.read('to_rotate.txt').lines.map(&:chomp).map(&:chars)
    times.times do
        to_rotate = to_rotate.transpose.map(&:reverse)
    end
    to_rotate.each do |l|
        puts l.join
    end
end

def get_delta(dir)
    case dir
    when :right
        return [0, 1]
    when :down
        return [1, 0]
    when :left
        return [0, -1]
    when :up
        return [-1, 0]
    else
        raise 'Invalid direction received!'
    end
end

def day22_1
    board = Hash.new(' ')
    path_string = $lines[1].chomp
    dirs = [:right, :down, :left, :up]
    board_input = $lines[0].lines.map(&:chomp)
    board_input.each_with_index do |l, ri|
        l.chars.each_with_index{|ch, ci| board[[ri + 1, ci + 1]] = ch}
    end
    start_rc = [1, board_input[0].index(?.) + 1]
    curr = start_rc

    row_ends = {}
    # Start and end of each row
    (1..board_input.length).each do |r|
        col = 1
        start = board[[r, col]]
        while start == ' '
            col += 1
            start = board[[r, col]]
        end
        left_end = col
        until start == ' '
            col += 1
            start = board[[r, col]]
        end
        right_end = col - 1
        row_ends[r] = [left_end, right_end]
    end

    col_ends = {}
    # Start and end of each column
    (1..board_input[1].length).each do |c|
        row = 1
        start = board[[row, c]]
        while start == ' '
            row += 1
            start = board[[row, c]]
        end
        left_end = row
        until start == ' '
            row += 1
            start = board[[row, c]]
        end
        right_end = row - 1
        col_ends[c] = [left_end, right_end]
    end

    steps = path_string.scan(/\d+/).map(&:to_i)
    rotates = path_string.scan(/(R|L)/)
    path = steps.zip(rotates).flatten.compact

    current_dir = 0
    path.each do |inst|
        case inst
        when ?R
            current_dir = (current_dir + 1) % 4
        when ?L
            current_dir = (current_dir - 1) % 4
        else
            dx, dy = get_delta(dirs[current_dir])
            inst.times do
                next_move = [curr[0] + dx, curr[1] + dy]
                if board[next_move] == ' '
                    case dirs[current_dir]
                    when :right
                        next_move = [curr[0], row_ends[curr[0]][0]]
                    when :down
                        next_move = [col_ends[curr[1]][0], curr[1]]
                    when :left
                        next_move = [curr[0], row_ends[curr[0]][1]]
                    when :up
                        next_move = [col_ends[curr[1]][1], curr[1]]
                    else
                        raise 'Invalid direction received!'
                    end
                end
                if board[next_move] == ?.
                    curr = next_move
                elsif board[next_move] == ?#
                    break
                else
                    raise "Invalid next move! (Probably a space when it shouldn't have been)"
                end
            end
        end
    end
    pp [1000 * curr[0], 4 * curr[1], current_dir].sum
    start_rc
end

def day22_2(start_rc)
    file = 'cube_input.txt'
    input = File.read(file)
    lines = input.split("\n\n")

    board = Hash.new(' ')
    path_string = lines[1].chomp
    dirs = [:right, :down, :left, :up]
    board_input = lines[0].lines.map(&:chomp)
    board_input.each_with_index do |l, ri|
        l.chars.each_with_index{|ch, ci| board[[ri + 1, ci + 1]] = ch}
    end
    pp start_rc
    curr = [4, 1]

    row_ends = {}
    # Start and end of each row
    (1..board_input.length).each do |r|
        col = 1
        start = board[[r, col]]
        while start == ' '
            col += 1
            start = board[[r, col]]
        end
        left_end = col
        until start == ' '
            col += 1
            start = board[[r, col]]
        end
        right_end = col - 1
        row_ends[r] = [left_end, right_end]
    end

    col_ends = {}
    # Start and end of each column
    (1..board_input[1].length).each do |c|
        row = 1
        start = board[[row, c]]
        while start == ' '
            row += 1
            start = board[[row, c]]
        end
        left_end = row
        until start == ' '
            row += 1
            start = board[[row, c]]
        end
        right_end = row - 1
        col_ends[c] = [left_end, right_end]
    end

    steps = path_string.scan(/\d+/).map(&:to_i)
    rotates = path_string.scan(/(R|L)/)
    path = steps.zip(rotates).flatten.compact

    current_dir = 0
    path.each do |inst|
        case inst
        when ?R
            current_dir = (current_dir + 1) % 4
        when ?L
            current_dir = (current_dir - 1) % 4
        else
            dx, dy = get_delta(dirs[current_dir])
            inst.times do
                next_move = [curr[0] + dx, curr[1] + dy]
                next_dir = current_dir
                if board[next_move] == ' '
                    case dirs[current_dir]
                    when :right
                        if (51..100).cover?(curr[0])
                            next_move = [50, 50 + curr[0]]
                            next_dir = 3
                        elsif (101..150).cover?(curr[0])
                            next_move = [50 - (curr[0] - 100) + 1, 150]
                            next_dir = 2
                        elsif (151..200).cover?(curr[0])
                            next_move = [1, 50 - (curr[0] - 150) + 100 + 1]
                            next_dir = 1
                        else
                            # Top row
                            next_move = [curr[0], row_ends[curr[0]][0]]
                        end
                    when :down
                        if (1..50).cover?(curr[1])
                            next_move = [50 + (50 - curr[1] + 1), 51]
                            next_dir = 0
                        elsif (101..150).cover?(curr[1])
                            next_move = [curr[1] - 50, 100]
                            next_dir = 2
                        else
                            # Middle column
                            next_move = [col_ends[curr[1]][0], curr[1]]
                        end
                    when :left
                        if (51..100).cover?(curr[0])
                            next_move = [50, 50 - (curr[0] - 50) + 1]
                            next_dir = 3
                        elsif (101..150).cover?(curr[0])
                            next_move = [50 - (curr[0] - 100) + 1, 1]
                            next_dir = 0
                        elsif (151..200).cover?(curr[0])
                            next_move = [1, curr[0] - 150]
                            next_dir = 1
                        else
                            # Top row
                            next_move = [curr[0], row_ends[curr[0]][1]]
                        end
                    when :up
                        if (1..50).cover?(curr[1])
                            next_move = [curr[1] + 150, 51]
                            next_dir = 0
                        elsif (101..150).cover?(curr[1])
                            next_move = [150 + (150 - curr[1] + 1), 100]
                            next_dir = 2
                        else
                            # Middle column
                            next_move = [col_ends[curr[1]][1], curr[1]]
                        end
                    else
                        raise 'Invalid direction received!'
                    end
                end
                if board[next_move] == ?.
                    curr = next_move
                    current_dir = next_dir
                elsif board[next_move] == ?#
                    break
                else
                    raise "Invalid next move! (Probably a space when it shouldn't have been)"
                end
            end
        end
    end
    pp curr
    [1000 * curr[0], 4 * curr[1], current_dir].sum
end

start = day22_1
# rotate(2)
pp day22_2(start)
