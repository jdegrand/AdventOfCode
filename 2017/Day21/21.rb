file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def rotate(arr, orientations)
    to_add = arr
    3.times do
        to_add = to_add.transpose.map(&:reverse)
        orientations << to_add
    end
end

# Have to rotate first...
def flip(orientations)
    new_orientations = []
    orientations.each do |o|
        new_orientations << o.map(&:reverse)
        new_orientations << o.reverse
    end
    orientations.concat(new_orientations)
end

def day21(n)
    rules = {}
    grid = ".#./..#/###".split(?/).map(&:chars)
    $lines.map do |l|
        match, resolve = l.split(" => ")
        rules[match.split(?/).map(&:chars)] = resolve.split(?/).map(&:chars)
    end

    n.times do
        new_grids = []
        if grid.length % 2 == 0
            (0...grid.length).step(2).each do |i|
                grid[i].each_slice(2).with_index do |(r0, r1), j|
                    new_grids.concat([[[r0, r1], [grid[i + 1][j * 2], grid[i + 1][j * 2 + 1]]]])
                end
            end
        elsif grid.length % 3 == 0
            (0...grid.length).step(3).each do |i|
                grid[i].each_slice(3).with_index do |(r0, r1, r2), j|
                    new_grids.concat([[[r0, r1, r2], [grid[i + 1][j * 3], grid[i + 1][j * 3 + 1], grid[i + 1][j * 3 + 2]], [grid[i + 2][j * 3], grid[i + 2][j * 3 + 1], grid[i + 2][j * 3 + 2]]]])
                end
            end
        end
        squares = new_grids.map do |ng|
            orientations = [ng]
            rotate(ng, orientations)
            flip(orientations)
            rules[orientations.detect{|o| rules.key?(o)}]
        end

        grid = squares.each_slice(Math.sqrt(squares.length)).map do |slice|
            slice.transpose.flatten.each_slice(Math.sqrt(squares.length) * slice[0].length).to_a
        end
        grid = grid.inject(&:concat)
    end
    grid.flatten.count(?#)
end


pp day21(5)
pp day21(18)
