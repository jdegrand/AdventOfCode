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
        x, y = 0, 0
        l.scan(reg).flatten.each do |d|
            case d
            when "e"
                x += 0.5
                y += 0.5
            when "w"
                x -= 0.5
                y -= 0.5
            when "ne"
                y += 1
            when "sw"
                y -= 1
            when "nw"
                x -= 0.5
                y += 0.5
            when "se"
                x += 0.5
                y -= 0.5
            end
        end
        tiles[[x, y]] = tiles[[x, y]] == :white ? :black : :white
    end
    tiles
end

def day24_2
    tiles = day24_1
    surrounding = [0.5, -0.5].product([-0.5, 0.5]) + [[0, 1]] + [[0, -1]]
    pp surrounding
    100.times do |day|
        new_tiles = tiles.clone
        tiles.each do |k, v|
            neighbors = surrounding.map{|dx, dy| [k[0] + dx, k[1] + dy]}.reject{|t| !tiles.include?(t)}
            pp neighbors
            neighbors = neighbors.map{|n| tiles[n]}
            b = neighbors.count(:black)
            if v == :black && (b == 0 || b > 2) then new_tiles[k] = :white end
            if v == :white && (b == 2) then new_tiles[k] = :black end
        end
        tiles = new_tiles
        counts = tiles.values.count{|v| v == :black}
        pp "Day: #{day + 1}  -  #{counts} Black Tiles"
    end

end

puts day24_1.values.count{|v| v == :black}
puts day24_2

