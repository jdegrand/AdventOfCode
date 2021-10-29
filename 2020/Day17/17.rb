file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def getNeighbors(x, y, z)
    [x, x-1, x+1].product([y, y-1, y+1]).product([z, z-1, z+1]).map(&:flatten).reject{|p| p == [x,y,z]}
end

def get4dNeighbors(x, y, z, w)
    [x, x-1, x+1].product([y, y-1, y+1]).product([z, z-1, z+1]).product([w, w-1, w+1]).map(&:flatten).reject{|p| p == [x,y,z,w]}
end

def day17_1
    grid = Hash.new('.')
    mx = [0, $lines[0].length]
    my = [0, $lines.length]
    mz = [0, 0]
    $lines.length.times do |y|
        $lines[0].length.times do |x|
            grid[[x,y,0]] = $lines[y][x]
        end
    end
    6.times do |_|
        last = grid.clone
        (mx[0]-1..mx[1]+1).to_a.each do |x|
            (my[0]-1..my[1]+1).to_a.each do |y|
                (mz[0]-1..mz[1]+1).to_a.each do |z|
                    if last[[x,y,z]] == ?.
                        grid[[x,y,z]] = getNeighbors(x,y,z).map{|nx, ny, nz| last[[nx,ny,nz]]}.count(?#) == 3 ? ?# : ?.
                    end
                    if last[[x,y,z]] == ?#
                        grid[[x,y,z]] = (2..3).cover?(getNeighbors(x,y,z).map{|nx, ny, nz| last[[nx,ny,nz]]}.count(?#)) ? ?# : ?.
                    end
                end
            end
        end
        mx = [mx[0] - 1, mx[1] + 1]
        my = [my[0] - 1, my[1] + 1]
        mz = [mz[0] - 1, mz[1] + 1]
    end
    grid.values.count(?#)
end

def day17_2
    grid = Hash.new('.')
    mx = [0, $lines[0].length]
    my = [0, $lines.length]
    mz = [0, 0]
    mw = [0, 0]
    $lines.length.times do |y|
        $lines[0].length.times do |x|
            grid[[x,y,0,0]] = $lines[y][x]
        end
    end
    6.times do |_|
        last = grid.clone
        (mx[0]-1..mx[1]+1).to_a.each do |x|
            (my[0]-1..my[1]+1).to_a.each do |y|
                (mz[0]-1..mz[1]+1).to_a.each do |z|
                    (mw[0]-1..mw[1]+1).to_a.each do |w|
                        if last[[x,y,z,w]] == ?.
                            grid[[x,y,z,w]] = get4dNeighbors(x,y,z,w).map{|nx, ny, nz, nw| last[[nx,ny,nz,nw]]}.count(?#) == 3 ? ?# : ?.
                        end
                        if last[[x,y,z,w]] == ?#
                            grid[[x,y,z,w]] = (2..3).cover?(get4dNeighbors(x,y,z,w).map{|nx, ny, nz, nw| last[[nx,ny,nz,nw]]}.count(?#)) ? ?# : ?.
                        end
                    end
                end
            end
        end
        mx = [mx[0] - 1, mx[1] + 1]
        my = [my[0] - 1, my[1] + 1]
        mz = [mz[0] - 1, mz[1] + 1]
        mw = [mw[0] - 1, mw[1] + 1]
    end
    grid.values.count(?#)
end

puts day17_1
puts day17_2

