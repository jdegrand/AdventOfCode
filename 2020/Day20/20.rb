require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n")

#     #.#.#####.
#     .#..######
#     ..#.......
#     ######....
#     ####.#..#.
#     .#...#.##.
#     #.#####.##
#     ..#.###...
#     ..#.......
#     ..#.###...

class Tile
    def initialize(tid, board)
        @tid = tid
        @board = board
    end

    def getEdges
        edges = []
        edges << @board[0]
        edges << @board[-1]
        edges << @board.map{|r| r[0]}.join
        edges << @board.map{|r| r[-1]}.join
        edges += edges.map{|e| e.reverse}
    end

    def arrayCombinations
        combs = []
        curr = @board.map{|r| r.split("")}
        4.times do
            combs << Tile.new(@tid, curr.map(&:join))
            curr = curr.transpose.map(&:reverse)
        end
        curr = curr.map{|r| r.reverse}
        4.times do
            combs << Tile.new(@tid, curr.map(&:join))
            curr = curr.transpose.map(&:reverse)
        end
        @combinations = combs
    end

    def transposeBoard
        @board = @board.map{|r| r.split("")}.transpose.map(&:join)
    end

    attr_accessor :tid
    attr_accessor :board
    attr_accessor :combinations
end

def day20_1
    visited = Set.new
    tile_list = []
    edges = Hash.new([])
    $lines.each do |l|
        sp = l.split("\n")
        id = sp[0].match(/\ATile (\d+):\Z/).captures.map(&:to_i)[0]
        tile = Tile.new(id, sp[1..])
        tile_list << tile
        tile.getEdges.each do |e|
            edges[e] += [id]
        end
    end
    filtered = edges.reject{|e| e.length < 2}
    tile_list.map{ |t| [t.getEdges.count{|e| filtered[e].length > 1}, t.tid] }.sort_by{|x, _| x}[0...4].map{|_, tid| tid}.reduce(:*)
end

def checkValid(c, row, col, grid, emptyTile)
    topValid = false
    leftValid = false
    if row == 0 && col == 0 then return true end
    if row == 0
        topValid = true
    else
        topValid = grid[[row - 1, col]].board[-1] == c.board[0]
    end
    if col == 0
        leftValid = true
    else
        leftValid = grid[[row, col - 1]].board.map{|r| r[-1]}.join == c.board.map{|r| r[0]}.join
    end
    return topValid && leftValid
end

def solveBoard(row, col, tile_list, visited_ref, grid, size, emptyTile, count)
    if row == size
        return true
    end
    visited = visited_ref.map(&:clone)
    tile_list.length.times do |i|
        t = tile_list[i]
        if !visited.include?(t.tid)
            visited += [t.tid]
            t.combinations.each do |c|
                if checkValid(c, row, col, grid, emptyTile)
                    grid[[row, col]] = c
                    if col + 1 == size
                        if solveBoard(row + 1, 0, tile_list, visited, grid, size, emptyTile, count+1) == true then return true end
                    else
                        if solveBoard(row, col + 1, tile_list, visited, grid, size, emptyTile, count+1) == true then return true end
                    end
                end
            end
            grid[[row, col]] = emptyTile
            visited -= [t.tid]
        end
    end
end

def getGrid(grid, size)
    conjoined = []
    size.to_i.times do |c|
        8.times do |t|
            s = ""     
            size.to_i.times do |r|
                s += grid[[r,c]].board[t+1][1...-1]
            end
            conjoined << s
        end
    end
    conjoined
end

def day20_2
    tile_list = []
    edges = Hash.new([])
    $lines.each do |l|
        sp = l.split("\n")
        id = sp[0].match(/\ATile (\d+):\Z/).captures.map(&:to_i)[0]
        tile = Tile.new(id, sp[1..])
        tile_list << tile
        tile.getEdges.each do |e|
            edges[e] += [id]
        end
    end
    filtered = edges.reject{|e| e.length < 2}
    corner = tile_list.map{ |t| [t.getEdges.count{|e| filtered[e].length > 1}, t.tid] }.sort_by{|x, _| x}[0][1]
    corner = tile_list.detect{|t| t.tid == corner}
    tile_list.each{|t| t.arrayCombinations}
    visited = Set.new
    emptyTile = Tile.new(-1, [""])
    grid = Hash.new(emptyTile)
    size = Math.sqrt(tile_list.length)
    tile_list = tile_list.reject{|t| t.tid == corner.tid}.unshift(corner)
    visited = []
    solveBoard(0, 0, tile_list, visited, grid, size, emptyTile, 0)
    grid.map{|_, t| t.transposeBoard}
    image = getGrid(grid, size)
    sea_monster_1 = Regexp.new("\\A                  # ".gsub(" ", "."))
    sea_monster_2 = Regexp.new("\\A#    ##    ##    ###".gsub(" ", "."))
    sea_monster_3 = Regexp.new("\\A #  #  #  #  #  #   ".gsub(" ", "."))
    counts = []
    image_tile = Tile.new(2020, image)
    image_tile.arrayCombinations
    image_tile.combinations.each do |c|
        count = 0
        (c.board.length - 2).times do |r|
            (c.board[r].length - 10).times do |t|
                ind1 = c.board[r][t..].index(sea_monster_1)
                ind2 = c.board[r+1][t..].index(sea_monster_2)
                ind3 = c.board[r+2][t..].index(sea_monster_3)
                if ind1 && ind1 == ind2 && ind1 == ind3
                    count += 1
                end
            end
        end
        counts << count
    end
    image.join.count("#") - (counts.max * 15)
end

pp day20_1
pp day20_2
