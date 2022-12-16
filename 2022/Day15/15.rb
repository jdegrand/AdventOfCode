require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day15_1
    rows = Hash.new(Set.new)
    beacons = Set.new
    scanners = Set.new
    $lines.each do |l|
        sx, sy, bx, by = l.scan(/-?\d+/).map(&:to_i)
        scanners << [sx, sy]
        beacons << [bx, by]
        manhat = (sx - bx).abs + (sy - by).abs
        # if l == 'Sensor at x=8, y=7: closest beacon is at x=2, y=10'
            ((sy - manhat)..(sy + manhat)).each do |lsy|
                dx = manhat - lsy.abs
                rows[lsy] <<= ((sx - dx)..(sx + dx))
                # ((sx - dx)..(sx + dx)).each do |lsx|
                #     rows[]
                # end
            end
        # end
    end
    row_set = Set.new
    rows[10].each{|range| range.each{|x| row_set << x}}
    pp row_set
    row_set.size - scanners.filter{|_, y| y == 10}.size - beacons.filter{|_, y| y == 10}.size
end

def day15_2
end

pp day15_1
pp day15_2
