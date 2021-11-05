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
    def initialize(id, board)
        @id = id
        @board = board
        @position = -1
        @coming_from = [-1, -1] #id, direction
    end

    def setPosition(p)
        @position = p
    end

    def setComingFrom(p)
        @coming_from = p
    end

    def getEdges
        edges = []
        edges << @board[0]
        edges << @board[-1]
        edges << @board.map{|r| r[0]}.join
        edges << @board.map{|r| r[-1]}.join
        edges += edges.map{|e| e.reverse}
    end

    def getSplitEdges
        edges1 = []
        edges1 << [@board[0], :t]
        edges1 << [@board[-1], :b]
        edges1 << [@board.map{|r| r[0]}.join, :l]
        edges1 << [@board.map{|r| r[-1]}.join, :r]

        edges2 = []
        edges2 << [@board[0], :t]
        edges2 << [@board[-1], :b]
        edges2 << [@board.map{|r| r[0]}.join.reverse, :r]
        edges2 << [@board.map{|r| r[-1]}.join.reverse, :l]

        edges3 = []
        edges3 << [@board[0].reverse, :b]
        edges3 << [@board[-1].reverse, :t]
        edges3 << [@board.map{|r| r[0]}.join, :l]
        edges3 << [@board.map{|r| r[-1]}.join, :r]

        [edges1, edges2, edges3]
    end

    attr_accessor :id
    attr_accessor :board
    attr_accessor :coming_from
end

def dfs(tiles_by_id, tiles, edges)
    stack = []
    visited = Set.new
    stack.push(tiles[0])
    while !stack.empty?
        t = stack.pop
        if !visited.include?(t.id)
            visited << t.id
            all_var = []
            splits = t.getSplitEdges
            splits.length.times do |i|
                se = splits[i]
                temp = Set.new
                se.each do |e|
                    edges[e[0]].reject{|v| v == t.id}.each do |d|
                        temp << [d, e[1]]
                    end
                end
                all_var << [temp.count, temp, i + 1]
            end
            max = all_var.max_by{|x, _, _| x}
            max[1].each do |tid|
                tile = tiles_by_id[tid[0]]
                dir = case tid[1]
                        when :r
                            :l
                        when :l
                            :r
                        when :t
                            :b
                        when :b
                            :t
                        end
                tile.setComingFrom([t.id, dir])
                tile.setPosition(max[2])
                stack << tile
            end
        end
    end
    tiles
end

def arrayCombinations(tile)
    combs = Set.new
    curr = tile.board.map{|r| r.split("")}
    4.times do
        combs << curr.map(&:join)
        curr = curr.transpose.map(&:reverse)
    end
    curr = curr.map{|r| r.reverse}
    4.times do
        combs << curr.map(&:join)
        curr = curr.transpose.map(&:reverse)
    end
    combs
end

def day20_2
    visited = Set.new
    tile_list = []
    tiles = {}
    edges = Hash.new(Set.new)
    $lines.each do |l|
        sp = l.split("\n")
        id = sp[0].match(/\ATile (\d+):\Z/).captures.map(&:to_i)[0]
        tile = Tile.new(id, sp[1..])
        tiles[id] = tile
        tile_list << tile
        tile.getSplitEdges.flatten.each do |e|
            edges[e] += [id]
        end
    end
    dfs(tiles, tile_list, edges)
    x = 0
    y = 0
    grid = {}
    grid[[x,y]] = tile_list[0]
    tile_list[1..].each do |t|
        case t.coming_from[1]
        when :r
            x += 1
        when :l
            x -= 1
        when :t
            y += 1
        when :b
            x -= 1
        end
        grid[[x,y]] = t
    end
    # pp grid
    arrayCombinations(tile_list[0])
    # min_x = grid.keys.min_by{|x, _| x}[0]
    # min_y = grid.keys.min_by{|_, y| y}[1]
    # size = Math.sqrt(grid.length)
    # (min_x...(min_x+size)).to_a.each do |dx|
    #     10.times do |t|
    #         s = ""
    #         (min_y...(min_y+size)).to_a.each do |dy|
    #             pp dx
    #             pp dy
    #             pp grid
    #             s += grid[[dx,dy]].board[t]
    #         end
    #         puts t
    #     end
    # end

    # tile_list[0]
    # edges
    # filtered = edges.reject{|e| e.length < 2}
    # tile_list.map{ |t| [t.getEdges.count{|e| filtered[e].length > 1}, t.id] }.sort_by{|x, _| x}[0...4].map{|_, id| id}.reduce(:*)
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
    tile_list.map{ |t| [t.getEdges.count{|e| filtered[e].length > 1}, t.id] }.sort_by{|x, _| x}[0...4].map{|_, id| id}.reduce(:*)
end

pp day20_1
pp day20_2

