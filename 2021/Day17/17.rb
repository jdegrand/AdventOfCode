file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def compute(vx, vy, maxy_list, xs, ys, xbound, ybound)
    cx, cy, maxy = 0, 0, 0
    while cx < xbound && cy > ybound
        cx += vx
        cy += vy
        vx += (0 <=> vx)
        vy -= 1
        maxy = [maxy, cy].max
        if xs.cover?(cx) && ys.cover?(cy)
            maxy_list << maxy
            return
        end
    end
end

def day17
    reg = /x=(?:(-?\d+)..(-?\d+)), y=(?:(-?\d+)..(-?\d+))/
    x0, x1, y0, y1 = $lines[0].match(reg).captures.map(&:to_i)
    $lines[0].match(reg).captures.map(&:to_i)

    xs = (x0..x1)
    ys = (y0..y1)

    xbound = [x0, x1].max + 1
    ybound = [y0, y1].min - 1

    vx = 7
    vy = 2

    maxy_list = []  
    (1...xbound).each do |vx|
        (ybound+1..1000).each do |vy|
            compute(vx, vy, maxy_list, xs, ys, xbound, ybound)
        end
    end
    pp maxy_list.max
    pp maxy_list.length
end

day17
