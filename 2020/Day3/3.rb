file = "input.txt"
input = File.read(file)

$lines = []

input.lines.map(&:chomp).each do |l|
    $lines << l
end

def day3_1(dx, dy)
    x = y = 0
    trees = 0
    while y < $lines.length
        if $lines[y][x % $lines[0].length] == "#"
            trees += 1
        end
        x += dx
        y+= dy
    end
    trees
end

def day3_2
    [[1,1],[3,1],[5,1],[7,1],[1,2]].map{|dx, dy| day3_1(dx, dy)}.inject(:*)
end

puts day3_1(3, 1)
puts day3_2
