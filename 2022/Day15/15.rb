require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day15_1
    row_to_check = 2000000
    rows = Hash.new{[]}
    beacons = Set.new
    scanners = Set.new
    $lines.each do |l|
        sx, sy, bx, by = l.scan(/-?\d+/).map(&:to_i)
        scanners << [sx, sy]
        beacons << [bx, by]
        manhat = (sx - bx).abs + (sy - by).abs
        ((sy - manhat)..sy).each_with_index do |y, i|
            rows[y] <<= [(sx - i), (sx + i)] if y == row_to_check
        end
        (sy..(sy + manhat)).each_with_index do |y, i|
            rows[y] <<= [(sx - (manhat  - i)), (sx + (manhat - i))] if y == row_to_check
        end
    end
    row_set = Set.new
    rows[row_to_check].each{|(l, r)| [*(l..r)].each{|n| row_set << n}}
    row_set.size - scanners.filter{|_, y| y == row_to_check}.size - beacons.filter{|_, y| y == row_to_check}.size
end

def day15_2
    rows = Hash.new{[]}
    beacons = Set.new
    scanners = Set.new
    $lines.each do |l|
        sx, sy, bx, by = l.scan(/-?\d+/).map(&:to_i)
        scanners << [sx, sy]
        beacons << [bx, by]
        manhat = (sx - bx).abs + (sy - by).abs
        ((sy - manhat)..sy).each_with_index do |y, i|
            rows[y] <<= [(sx - i), (sx + i)]
        end
        (sy..(sy + manhat)).each_with_index do |y, i|
            rows[y] <<= [(sx - (manhat  - i)), (sx + (manhat - i))]
        end
    end
    (0..4000000).each do |n|
        change = true
        while change
            change = false
            rows[n].each_with_index do |range, ri|
                rows[n].each_with_index do |subrange, si|
                    if ri != si
                        if range[0] <= subrange[0] && range[1] >= subrange[0] && range[1] <= subrange[1]
                            rows[n][ri] = [range[0], subrange[1]]
                            rows[n].delete_at(si)
                            change = true
                            break
                        elsif range[0] >= subrange[0] && range[1] <= subrange[1]
                            rows[n][ri] = [subrange[0], subrange[1]]
                            rows[n].delete_at(si)
                            change = true
                            break
                        elsif range[1] + 1 == subrange[0]
                            rows[n][ri] = [range[0], subrange[1]]
                            rows[n].delete_at(si)
                            change = true
                            break
                        end
                    end
                end
                break if change == true
            end
        end
        return ((rows[n].sort[1][0] - 1) * 4000000) + n if rows[n].length > 1
    end
end

pp day15_1
pp day15_2
