file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day11_1
    # https://www.redblobgames.com/grids/hexagons/
    # s, q, r
    coord = 0, 0, 0
    $lines[0].split(?,).each do |dir|
        case dir
        when "n"
            coord = [coord[0] + 1, coord[1], coord[2] - 1]
        when "s"
            coord = [coord[0] - 1, coord[1], coord[2] + 1]
        when "ne"
            coord = [coord[0], coord[1] + 1, coord[2] - 1]
        when "sw"
            coord = [coord[0], coord[1] - 1, coord[2] + 1]
        when "nw"
            coord = [coord[0] + 1, coord[1] - 1, coord[2]]
        when "se"
            coord = [coord[0] - 1, coord[1] + 1, coord[2]]
        end
    end
    [coord[0].abs, coord[2].abs].min + coord[1].abs
end

def day11_2
    # https://www.redblobgames.com/grids/hexagons/
    # s, q, r
    coord = 0, 0, 0
    max = 0
    $lines[0].split(?,).each do |dir|
        case dir
        when "n"
            coord = [coord[0] + 1, coord[1], coord[2] - 1]
        when "s"
            coord = [coord[0] - 1, coord[1], coord[2] + 1]
        when "ne"
            coord = [coord[0], coord[1] + 1, coord[2] - 1]
        when "sw"
            coord = [coord[0], coord[1] - 1, coord[2] + 1]
        when "nw"
            coord = [coord[0] + 1, coord[1] - 1, coord[2]]
        when "se"
            coord = [coord[0] - 1, coord[1] + 1, coord[2]]
        end
        max = [[coord[0].abs, coord[2].abs].min + coord[1].abs, max].max
    end
    max
end

pp day11_1
pp day11_2
