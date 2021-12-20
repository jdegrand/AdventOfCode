require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n")

def get_orientations(scanner)
    combs = []
    [0,1,2].each do |v|
        s = scanner.map{|r| r.rotate(v)}
        [-1,1].product([-1, 1], [-1, 1]) do |dx, dy, dz|
            temp = s.map{|x, y, z| [x * dx, y * dy, z * dz]}
            combs << [temp, [dx, dy, dz]]
        end
    end
    combs
end

def get_volumes(scanner)
    Set.new(scanner.map{|x, y, z| 1/2.0 * (y - x) * z})
end

def findOverlap(s1s, s2s, sn, overlaps)
    s1s.each_with_index do |s1, i|
        next if s1 == i
        s1.each do |r1|
            s2s.each do |s2, ds|
            next if sn == i
                s2.each do |r2|
                    dx = r1[0] - r2[0]
                    dy = r1[1] - r2[1]
                    dz = r1[2] - r2[2]
                    matchee = Set.new(s2.map{|x, y, z| [x + dx, y + dy, z + dz]})
                    common = s1 & matchee
                    if common.length >= 12 && !overlaps[sn][i]
                        overlaps[sn] = overlaps[sn].merge({i => [[dx, dy, dz], ds]})
                    end
                end
            end
        end
    end
end

def day19_1
    scanners = []
    locations = {}
    $lines.each do |l|
        scanner = []
        l.split("\n")[1..].each do |r|
            row = []
            r.split(?,).each do |c|
                row << c.to_i
            end
            scanner << row
        end
        scanners << scanner
    end
    origin_scanner = scanners[0]
    locations[0] = [0, 0, 0]
    overlaps = Hash.new({})
    scanners_sets = scanners.map{|s| Set.new(s)}
    scanners.each_with_index do |scan, i|
        findOverlap(scanners_sets, get_orientations(scan), i, overlaps)
    end
    queue = [0]
    while queue.any?
        curr = queue.shift
        cc = locations[curr]
        overlaps[curr].each do |k, (v, ds)|
        if !locations.keys.include?(k)
            queue << k
            locations[k] = [(cc[0] + v[0]) * ds[0], (cc[1] + v[1]) * ds[1], (cc[2] + v[2]) * ds[2]]
        end
    end
  end
  locations
  overlaps
end

def day19_2
end

pp day19_1
pp day19_2