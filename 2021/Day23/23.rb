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

def in_location(chr, r, c, board)
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
    pp board
    # If in hallway
    if piece.row == 1
        cols = valid_col < piece.col ? (valid_col...piece.col).to_a : (piece.col+1..valid_col).to_a
        if cols.count{|c| board[[1, c] == ?.]} == cols.length
            if board[[2, valid_col]] == ?.
                if board[[3, valid_col]] == ?.
                    moves << [3, valid_col]
                elsif board[[3, valid_col]] == piece.name
                    moves << [2, valid_col]
                end
            end
        end
    # If not in its column (can never stand in hallway anf column at same time)
    elsif (piece.col == valid_col && piece.row == 2 && board[[piece.row + 1, piece.col]] != piece.name) || (piece.col != valid_col && piece.row == 2)
        2.times do |t|
            dir = t == 0 ? -1 : 1
            curr = piece.col
            while board[[1, curr]] == ?.
                if ![3, 5, 7, 9].include?(curr)
                    moves << [1, curr] 
                end
                curr += dir
            end
        end
    elsif piece.row == 3 && piece.col != valid_col && board[[2, piece.col]] == ?.
        2.times do |t|
            dir = t == 0 ? -1 : 1
            curr = piece.col
            while board[[1, curr]] == ?.
                moves << [1, curr] if ![3, 5, 7, 9].include?(curr)
                curr += dir
            end
        end
    end

    moves
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
    pieces.reject!{|chr, (x, y)| in_location(chr, x, y, board)}
    pieces = pieces.map{|chr, (x, y)| Piece.new(chr, x, y)}
    pp pieces
    return get_moves(pieces[0], board)
    # distances = Hash.new(Float::INFINITY)
    # values = Hash.new(Float::INFINITY)

    # distances[[0,0]] = 0
    # visited = Set.new
    
    # unvisited = PQueue.new([Node.new([0, 0], 0)])

    # end_c = [$lines.length * 5 - 1, $lines[0].length * 5 - 1]

    # adj = [[0, -1], [0, 1], [-1, 0], [1, 0]]

    # until distances[end_c] < Float::INFINITY
    #     curr, val = unvisited.pop.fetch
    #     adj.each do |dx, dy|
    #         neigh = [curr[0] + dx, curr[1] + dy]
    #         if (!visited.include?(neigh)) && (val + values[neigh] < distances[neigh])
    #             distances[neigh] = val + values[neigh]
    #             unvisited.push(Node.new(neigh, val + values[neigh]))
    #         end
    #     end
    #     visited << curr
    # end

    # distances[end_c]
end

def day23_2
end

pp day23_1
pp day23_2
