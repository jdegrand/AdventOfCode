file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def dir_coords(dir)
    case dir
    when :up
        return [-1, 0]
    when :right
        return [0, 1]
    when :down
        return [1, 0]
    when :left
        return [0, -1]
    else
        raise 'Invalid direction found!'
    end
end

def day22_1
    grid = Hash.new(?.)
    $lines.each_with_index do |l, r|
        l.each_char.with_index do |chr, c|
            grid[[r, c]] = chr
        end
    end

    carrier = [$lines.length / 2, $lines[0].length / 2]
    dirs = [:up, :right, :down, :left]
    dir_ind = 0
    bursts = 0

    10000.times do
        case grid[carrier]
        when ?#
            dir_ind = (dir_ind + 1) % dirs.length
            grid[carrier] = ?.
        when ?.
            dir_ind = dir_ind == 0 ? dirs.length - 1 : dir_ind - 1
            grid[carrier] = ?#
            bursts += 1
        else
            raise 'Invalid character found!'
        end
        dr, dc = dir_coords(dirs[dir_ind])
        carrier = [carrier[0] + dr, carrier[1] + dc]
    end
    bursts
end

def day22_2
    grid = Hash.new(?.)
    $lines.each_with_index do |l, r|
        l.each_char.with_index do |chr, c|
            grid[[r, c]] = chr
        end
    end

    carrier = [$lines.length / 2, $lines[0].length / 2]
    dirs = [:up, :right, :down, :left]
    dir_ind = 0
    bursts = 0

    # ?- -> Weakened
    # ?^ -> Flagged
    10000000.times do
        case grid[carrier]
        when ?#
            dir_ind = (dir_ind + 1) % dirs.length
            grid[carrier] = ?^
        when ?.
            dir_ind = dir_ind == 0 ? dirs.length - 1 : dir_ind - 1
            grid[carrier] = ?-
        when ?-
            grid[carrier] = ?#
            bursts += 1
        when ?^
            dir_ind = (dir_ind + 2) % dirs.length
            grid[carrier] = ?.
        else
            raise 'Invalid character found!'
        end
        dr, dc = dir_coords(dirs[dir_ind])
        carrier = [carrier[0] + dr, carrier[1] + dc]
    end
    bursts
end

pp day22_1
pp day22_2
