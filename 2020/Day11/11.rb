file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)
$lines2 = input.lines.map(&:chomp)

def getNext(y, x, maxy, maxx)
    return '.' if $lines[y][x] == '.'
    adj = Hash.new(0)
    xs = [x - 1, x, x + 1]
    ys = [y - 1, y, y + 1]
    xs.select!{|e| e >= 0 && e < maxx}
    ys.select!{|e| e >= 0 && e < maxy}
    comb = ys.product(xs)
    comb.delete([y, x])
    comb.each do |dy, dx| 
        adj[$lines[dy][dx]] += 1
    end
    return '#' if $lines[y][x] == 'L' && adj['#'] == 0
    return 'L' if $lines[y][x] == '#' && adj['#'] >= 4
    return $lines[y][x]
end


$dir = [-1, 0, 1].product([-1,0,1]) - [[0,0]]

def getNext2(y, x, maxy, maxx)
    return '.' if $lines2[y][x] == '.'
    
    adj = Hash.new(0)
    $dir.each do |dy, dx|
        cx, cy = x + dx, y + dy
        while (0...maxx).cover?(cx) && (0...maxy).cover?(cy)
            if $lines2[cy][cx] != '.'
                adj[$lines2[cy][cx]] += 1
                break
            end
            cy += dy
            cx += dx
        end
    end
    return '#' if $lines2[y][x] == 'L' && adj['#'] == 0
    return 'L' if $lines2[y][x] == '#' && adj['#'] >= 5
    return $lines2[y][x]
end

def day11_1
    mx = $lines[0].length
    my = $lines.length
    it = 1
    while true
        curr = $lines.map(&:clone)
        mx.times do |x|
            my.times do |y|
                curr[y][x] = getNext(y, x, my, mx)
            end
        end
        if $lines == curr
            return curr.map{|l|
                l.count('#')
            }.sum
        end
        $lines = curr
    end
end

def day11_2
    mx = $lines2[0].length
    my = $lines2.length
    it = 1
    while true
        curr = $lines2.map(&:clone)
        mx.times do |x|
            my.times do |y|
                curr[y][x] = getNext2(y, x, my, mx)
            end
        end
        if $lines2 == curr
            return curr.map{|l|
                l.count('#')
            }.sum
        end
        $lines2 = curr
    end
end

puts day11_1
puts day11_2

