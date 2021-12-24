require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

class Piece
    def initialize(name, row, col)
        @name = name
        @row = row
        @col = col
        @cost = case name
            when ?A then 1
            when ?B then 10
            when ?C then 100
            when ?D then 1000
            else 100000000
        end
    end

    def fetch
        [@name, @coord, @cost]
    end

    def <=>(comp)
        -1 * (self.cost <=> comp.cost)
    end

    attr_accessor :name, :row, :col, :cost
end

def in_location(piece, board)
    chr = piece.name
    r = piece.row
    c = piece.col
    col = case chr
        when ?A then 3
        when ?B then 5
        when ?C then 7
        when ?D then 9
        else 11
    end

    return true if r == 2 && c == col && board[[3, c]] == chr
    return true if r == 3 && c == col
    false
end
# - Amphipods will never stop on the space immediately outside any room.
# - Amphipods will never move from the hallway into a room unless that room is
#   their destination room and that room contains no amphipods which do not also
#   have that room as their own destination
# - Once an amphipod stops moving in the hallway, it will stay in that spot until
#   it can move into a room.
def get_moves(piece, board)
    valid_col = case piece.name
        when ?A then 3
        when ?B then 5
        when ?C then 7
        when ?D then 9
        else 11
    end

    moves = []
    # If in hallway
    if piece.row == 1
        cols = valid_col < piece.col ? (valid_col...piece.col).to_a : (piece.col+1..valid_col).to_a
        if cols.count{|c| board[[1, c]] == ?.} == cols.length
            if board[[2, valid_col]] == ?.
                if board[[3, valid_col]] == ?.
                    moves << [[3, valid_col], (cols.count + 2) * piece.cost]
                elsif board[[3, valid_col]] == piece.name
                    moves << [[2, valid_col], (cols.count + 1) * piece.cost]
                end
            end
        end
    # If not in its column (can never stand in hallway anf column at same time)
    elsif (piece.col == valid_col && piece.row == 2 && board[[piece.row + 1, piece.col]] != piece.name) || (piece.col != valid_col && piece.row == 2)
        2.times do |t|
            dir = t == 0 ? -1 : 1
            curr = piece.col
            steps = 1
            while board[[1, curr]] == ?.
                moves << [[1, curr], steps * piece.cost] if ![3, 5, 7, 9].include?(curr)
                steps += 1
                curr += dir
            end
        end
    elsif piece.row == 3 && piece.col != valid_col && board[[2, piece.col]] == ?.
        2.times do |t|
            dir = t == 0 ? -1 : 1
            curr = piece.col
            steps = 2
            while board[[1, curr]] == ?.
                moves << [[1, curr], steps * piece.cost] if ![3, 5, 7, 9].include?(curr)
                steps += 1
                curr += dir
            end
        end
    end

    moves
end

def print_board(board)
    5.times do |r|
        s = ""
        13.times do |c|
            s += board[[r, c]]
        end
        puts s
    end
end

def print_board2(board)
    board.each{|r| puts r}
    sleep(1)
end

def get_board(board)
    rows = []
    5.times do |r|
        s = ""
        13.times do |c|
            s += board[[r, c]]
        end
        rows << s
    end
    rows
end

def dfs(pieces, board, results, sum, boards, seen, min_sum, depth)
    min_sum[0] = sum if !pieces.any? && sum < min_sum[0]
    return if sum > min_sum[0]
    # pp pieces
    # sleep(3)
    # print_board(board)
    # pp sum if sum < 13000 && !pieces.any?
    # pp pieces.any?
    results << [sum, boards] unless pieces.any?
    # unless pieces.any?
    #     boards.each do |b|
    #         print_board2(b)
    #         sleep(1)
    #     end
    # end
    pieces.each_with_index do |piece, pi|
        moves = get_moves(piece, board)
        moves.each do |move, cost|
            new_piece = piece.clone
            new_board = board.clone
            new_piece.row = move[0]
            new_piece.col = move[1]
            new_board[move] = piece.name
            new_board[[piece.row, piece.col]] = ?.
            new_pieces = pieces.clone
            if in_location(new_piece, new_board)
                new_pieces.delete_at(pi)
            else
                new_pieces[pi] = new_piece
            end
            if (!seen.key?(new_board)) || (seen.key?(new_board) && seen[new_board] > sum + cost)
                seen[new_board] = sum + cost
                # if sum + cost == 40 || depth == 1
                #     print_board(new_board)
                #     puts sum + cost
                #     puts
                #     puts
                    dfs(new_pieces, new_board, results, sum + cost, boards + [get_board(new_board)], seen, min_sum, depth + 1)
                # end
            end
        end
    end
end

def day23_1
    board = Hash.new(?#)
    pieces = []
    pieces_chars = Set.new([?A, ?B, ?C, ?D])

    $lines.each_with_index do |row, i|
        row.chars.each_with_index do |chr, j|
            board[[i, j]] = chr
            pieces << [chr, [i, j]] if pieces_chars.include?(chr)
        end
    end
    pieces = pieces.map{|chr, (x, y)| Piece.new(chr, x, y)}.reject{|piece| in_location(piece, board)}
    # pp pieces
    # return get_moves(pieces[5], board)
    results = []
    seen = {}
    dfs(pieces, board, results, 0, [], seen, [Float::INFINITY], 0)
    m = results.min_by{|s, _| s}
    print_board2(m[1])
    pp m[0]
end

def day23_2
end

pp day23_1
pp day23_2
