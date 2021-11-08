file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)
$PI = Math::PI

def sin(x)
    Math.sin(x*$PI/180)
end

def cos(x)
    Math.cos(x*$Pi/180)
end

def tan(x)

end

def day24_1
    tiles = Hash.new(:white)
    reg = /(ne|nw|se|sw|e|w)/
    $lines.each do |l|
        x, y, z = 0, 0, 0
        l.scan(reg).flatten.each do |d|
            case d
            when "e"
                x += 1
                z -= 1
            when "w"
                x -= 1
                z += 1
            when "ne"
                y += 1
                z -= 1
            when "sw"
                y -= 1
                z += 1
            when "nw"
                x -= 1
                y += 1
            when "se"
                x += 1
                y -= 1
            end
        end
        tiles[[x, y, z]] = tiles[[x, y, z]] == :white ? :black : :white
    end
    tiles
end

def day24_2
    tiles = day24_1
    surrounding = [[1, 0, -1], [-1, 0, 1], [0, 1, -1], [0, -1, 1], [-1, 1, 0], [1, -1, 0]]
    100.times do |day|
        new_tiles = tiles.clone
        tiles.each do |k, v|
            neighbors = surrounding.map{|dx, dy, dz| [k[0] + dx, k[1] + dy, k[2] + dz]}
            neighbors = neighbors.map{|n| [n, tiles[n]]}
            b = neighbors.count{|c, val| val == :black}
            if v == :black && (b == 0 || b > 2) then new_tiles[k] = :white end
            if v == :white && (b == 2) then new_tiles[k] = :black end
            neighbors.each do |c, col|
                new_neighbors = surrounding.map{|dx, dy, dz| [c[0] + dx, c[1] + dy, c[2] + dz]}
                new_neighbors = new_neighbors.map{|n| tiles[n]}
                sb = new_neighbors.count(:black)
                if col == :black && (sb == 0 || sb > 2) then new_tiles[c] = :white end
                if col == :white && (sb == 2) then new_tiles[c] = :black end
            end
        end
        tiles = new_tiles
        # counts = new_tiles.values.count{|v| v == :black}
        # pp "Day: #{day + 1}  -  #{counts} Black Tiles"
    end
    tiles.values.count{|v| v == :black}
end

puts day24_1.values.count{|v| v == :black}
puts day24_2

