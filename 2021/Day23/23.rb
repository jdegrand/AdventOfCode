require 'set'

file = 'input.txt'
file_2 = 'input_part2.txt'

input = File.read(file)
input_2 = File.read(file_2)

$lines = input.lines.map(&:chomp)
$lines_2 = input_2.lines.map(&:chomp)

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

    attr_accessor :name, :row, :col, :cost
end

# def in_location(piece, board)
#     chr = piece.name
#     r = piece.row
#     c = piece.col
#     col = case chr
#         when ?A then 3
#         when ?B then 5
#         when ?C then 7
#         when ?D then 9
#         else 11
#     end

#     return true if r == 2 && c == col && board[[3, c]] == chr
#     return true if r == 3 && c == col
#     false
# end

# # - Amphipods will never stop on the space immediately outside any room.
# # - Amphipods will never move from the hallway into a room unless that room is
# #   their destination room and that room contains no amphipods which do not also
# #   have that room as their own destination
# # - Once an amphipod stops moving in the hallway, it will stay in that spot until
# #   it can move into a room.
# def get_moves(piece, board)
#     valid_col = case piece.name
#         when ?A then 3
#         when ?B then 5
#         when ?C then 7
#         when ?D then 9
#         else 11
#     end
#     moves = []

#     # If in hallway
#     if piece.row == 1
#         cols = valid_col < piece.col ? (valid_col...piece.col).to_a : (piece.col+1..valid_col).to_a
#         if cols.count{|c| board[[1, c]] == ?.} == cols.length
#             if board[[2, valid_col]] == ?.
#                 if board[[3, valid_col]] == ?.
#                     moves << [[3, valid_col], (cols.count + 2) * piece.cost]
#                 elsif board[[3, valid_col]] == piece.name
#                     moves << [[2, valid_col], (cols.count + 1) * piece.cost]
#                 end
#             end
#         end
#     # If not in its column (can never stand in hallway anf column at same time)
#     elsif (piece.col == valid_col && piece.row == 2 && board[[piece.row + 1, piece.col]] != piece.name) || (piece.col != valid_col && piece.row == 2)
#         2.times do |t|
#             dir = t == 0 ? -1 : 1
#             curr = piece.col
#             steps = 1
#             while board[[1, curr]] == ?.
#                 moves << [[1, curr], steps * piece.cost] if ![3, 5, 7, 9].include?(curr)
#                 steps += 1
#                 curr += dir
#             end
#         end
#     elsif piece.row == 3 && piece.col != valid_col && board[[2, piece.col]] == ?.
#         2.times do |t|
#             dir = t == 0 ? -1 : 1
#             curr = piece.col
#             steps = 2
#             while board[[1, curr]] == ?.
#                 moves << [[1, curr], steps * piece.cost] if ![3, 5, 7, 9].include?(curr)
#                 steps += 1
#                 curr += dir
#             end
#         end
#     end
#     moves
# end

# def dfs(pieces, board, sum, seen, min_sum)
#     min_sum[0] = sum if !pieces.any? && sum < min_sum[0]
#     return if sum > min_sum[0]
#     pieces.each_with_index do |piece, pi|
#         moves = get_moves(piece, board)
#         moves.each do |move, cost|
#             new_piece = piece.clone
#             new_board = board.clone
#             new_piece.row = move[0]
#             new_piece.col = move[1]
#             new_board[move] = piece.name
#             new_board[[piece.row, piece.col]] = ?.
#             new_pieces = pieces.clone
#             if in_location(new_piece, new_board)
#                 new_pieces.delete_at(pi)
#             else
#                 new_pieces[pi] = new_piece
#             end
#             if (!seen.key?(new_board)) || (seen.key?(new_board) && seen[new_board] > sum + cost)
#                 seen[new_board] = sum + cost
#                 dfs(new_pieces, new_board, sum + cost, seen, min_sum)
#             end
#         end
#     end
# end

# def day23_1
#     board = Hash.new(?#)
#     pieces = []
#     pieces_chars = Set.new([?A, ?B, ?C, ?D])

#     $lines.each_with_index do |row, i|
#         row.chars.each_with_index do |chr, j|
#             board[[i, j]] = chr
#             pieces << [chr, [i, j]] if pieces_chars.include?(chr)
#         end
#     end
#     pieces = pieces.map{|chr, (x, y)| Piece.new(chr, x, y)}.reject{|piece| in_location(piece, board)}
#     seen = {}
#     min_sum = [Float::INFINITY]
#     dfs(pieces, board, 0, seen, min_sum)
#     min_sum[0]
# end




def in_location_2(piece, board)
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

    return true if r == 2 && c == col && board[[3, c]] == chr && board[[4, c]] == chr && board[[5, c]] == chr
    return true if r == 3 && c == col && board[[4, c]] == chr && board[[5, c]] == chr
    return true if r == 4 && c == col && board[[5, c]] == chr
    return true if r == 5 && c == col
    false
end

# - Amphipods will never stop on the space immediately outside any room.
# - Amphipods will never move from the hallway into a room unless that room is
#   their destination room and that room contains no amphipods which do not also
#   have that room as their own destination
# - Once an amphipod stops moving in the hallway, it will stay in that spot until
#   it can move into a room.
def get_moves_2(piece, board)
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
            if board[[2, valid_col]] == ?. && board[[3, valid_col]] == piece.name && board[[4, valid_col]] == piece.name && board[[5, valid_col]] == piece.name
                moves << [[2, valid_col], (cols.count + 1) * piece.cost]
            elsif board[[2, valid_col]] == ?. && board[[3, valid_col]] == ?. && board[[4, valid_col]] == piece.name && board[[5, valid_col]] == piece.name
                moves << [[3, valid_col], (cols.count + 2) * piece.cost]
            elsif board[[2, valid_col]] == ?. && board[[3, valid_col]] == ?. && board[[4, valid_col]] == ?. && board[[5, valid_col]] == piece.name
                moves << [[4, valid_col], (cols.count + 3) * piece.cost]
            elsif board[[2, valid_col]] == ?. && board[[3, valid_col]] == ?. && board[[4, valid_col]] == ?. && board[[5, valid_col]] == ?.
                moves << [[5, valid_col], (cols.count + 4) * piece.cost]
            end
        end
    # If right column and something is underneath and nothing above
    # If in wrong column completely and nothing above
    elsif piece.row >= 2
        below = (piece.row+1..5).to_a
        above = (2..piece.row-1).to_a
        if ((piece.col == valid_col && below.count{|c| c != piece.name} != 0 && below.length != 0 && above.length != 0) || (piece.col != valid_col)) && (above.count{|c| c != ?.} == 0)
            2.times do |t|
                dir = t == 0 ? -1 : 1
                curr = piece.col
                steps = 1 + above.length
                while board[[1, curr]] == ?.
                    moves << [[1, curr], steps * piece.cost] if ![3, 5, 7, 9].include?(curr)
                    steps += 1
                    curr += dir
                end
            end
        end
    end
    moves
end

def dfs_2(pieces, board, sum, seen, min_sum)
    min_sum[0] = sum if !pieces.any? && sum < min_sum[0]
    return if sum > min_sum[0]
    pieces.each_with_index do |piece, pi|
        moves = get_moves_2(piece, board)
        moves.each do |move, cost|
            new_piece = piece.clone
            new_board = board.clone
            new_piece.row = move[0]
            new_piece.col = move[1]
            new_board[move] = piece.name
            new_board[[piece.row, piece.col]] = ?.
            new_pieces = pieces.clone
            if in_location_2(new_piece, new_board)
                new_pieces.delete_at(pi)
            else
                new_pieces[pi] = new_piece
            end
            if (!seen.key?(new_board)) || (seen.key?(new_board) && seen[new_board] > sum + cost)
                seen[new_board] = sum + cost
                dfs_2(new_pieces, new_board, sum + cost, seen, min_sum)
            end
        end
    end
end

def day23_2
    board = Hash.new(?#)
    pieces = []
    pieces_chars = Set.new([?A, ?B, ?C, ?D])

    $lines_2.each_with_index do |row, i|
        row.chars.each_with_index do |chr, j|
            board[[i, j]] = chr
            pieces << [chr, [i, j]] if pieces_chars.include?(chr)
        end
    end
    pieces = pieces.map{|chr, (x, y)| Piece.new(chr, x, y)}.reject{|piece| in_location_2(piece, board)}
    # pp get_moves_2(pieces[0], board)
    seen = {}
    min_sum = [Float::INFINITY]
    dfs_2(pieces, board, 0, seen, min_sum)
    min_sum[0]
end

# pp day23_1
pp day23_2
