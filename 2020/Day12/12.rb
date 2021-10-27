file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

$pi = Math::PI

def day12_1
    dir = %w( E S W N )
    d = 0
    y = 0
    x = 0
    $lines.each do |l|
        inst, val = l[0], l[1..].to_i
        inst = dir[d] if inst == ?F
        case inst
        when ?N
            y += val
        when ?S
            y -= val
        when ?E
            x += val
        when ?W
            x -= val
        when ?L
            d = [0,1,2,3][d - (val / 90)]
        when ?R
            d = (d + val / 90) % 4
        end
    end
    x.abs + y.abs
end

def rotate(deg, x, y)
    rot = [[x, y],[y, -x],[-x, -y],[-y, x]]
    deg < 0 ? rot[deg/90] : rot[deg/90 % 4]
end

def day12_2
    wy, wx = 1, 10
    y, x = 0, 0
    $lines.each do |l|
        inst, val = l[0], l[1..].to_i
        case inst
        when ?F
            y += (val * wy)
            x += (val * wx)
        when ?N
            wy += val
        when ?S
            wy -= val
        when ?E
            wx += val
        when ?W
            wx -= val
        when ?L
            wx, wy = rotate(-val, wx, wy)
        when ?R
            wx, wy = rotate(val, wx, wy)
        end
    end
    (x.abs + y.abs).to_i
end

puts day12_1
puts day12_2

