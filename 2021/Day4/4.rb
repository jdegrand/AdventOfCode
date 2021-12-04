file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n")

def winner(board)
    return true if board.any?{|r| r.map{|tr| tr[1]}.all?}
    board[0].length.times do |i|
        return true if board.map{|r| r[i]}.map{|tr| tr[1]}.all?
    end
    leftDiag = (0...board[0].length).to_a.map{|i| [i, i]}
    rightDiag = (0...board[0].length).to_a.map{|i| [i, board[0].length - i - 1]}

    # return true if leftDiag.map{|r, c| board[r][c][1]}.all?
    # return true if rightDiag.map{|r, c| board[r][c][1]}.all?

    return false
end

def markNumber(board, n)
    board.each_with_index do |r, ri|
        r.each_with_index do |c, ci|
            board[ri][ci] = [n, true] if n == c[0]
        end
    end
end

def day4_1
    $lines = $lines.map(&:chomp)
    nums = $lines[0].split(",")
    boards = []

    $lines[1..].each do |r|
        b = r.split("\n")
        boards << b.map{|sb| sb.split.map{|v| [v, false]}}
    end

    nums.each do |n|
        boards.each do |b|
            markNumber(b, n)
        end

        boards.each do |b|
            if winner(b)
                sum = 0
                b.each do |r|
                    r.each do |num, bool|
                        sum += num.to_i if !bool
                    end
                end
                return sum * n.to_i
            end
        end
    end
end

def day4_2
    $lines = $lines.map(&:chomp)
    nums = $lines[0].split(",")
    boards = []

    $lines[1..].each do |r|
        b = r.split("\n")
        boards << b.map{|sb| sb.split.map{|v| [v, false]}}
    end

    nums.each do |n|
        boards.each do |b|
            markNumber(b, n)
        end

        boards = boards.reject do |b|
            win = winner(b)
            if boards.length == 1 && win
                sum = 0
                boards[0].each do |r|
                    r.each do |num, bool|
                        sum += num.to_i if !bool
                    end
                end
                return sum * n.to_i
            end
            win
        end
    end
end

pp day4_1
pp day4_2