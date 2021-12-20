require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n")

def get_orientations(scanners)
    scanner_variations = {}
    scanners.each_with_index do |scanner, i|
        combs = {}
        [0,1,2].each do |v|
            s = scanner.map{|r| r.rotate(v)}
            combs[v] = Set.new(s)
        end
        scanner_variations[i] = combs
    end
    scanner_variations
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

def find_matches(id, oriented, all_orientations, locations, queue)
    oriented[id].to_a.each do |b|
        all_orientations.each do |i, vals|
            next if id == i
            next if locations.keys.include?(i)
            vals.each do |rot, set|
                break if locations.keys.include?(i)
                set.each do |beacon|
                    [-1, 1].product([-1, 1], [-1, 1]).each do |tx, ty, tz|
                        dx = (tx * beacon[0]) - b[0]
                        dy = (ty * beacon[1]) - b[1]
                        dz = (tz * beacon[2]) - b[2]
                        temp = Set.new(set.map{|x, y, z| [(tx * x) - dx, (ty * y) - dy, (tz * z) - dz]})
                        if (oriented[id] & temp).length >= 1
                            locations[i] = [-dx, -dy, -dz]
                            oriented[i] = temp
                            temp.each do |x, y, z|
                                oriented[id] <<= [x + dx, y + dy, z + dz]
                                # all_beacons[[x - dx, y - dy, z - dz]] = true
                                # combines << [x - dx, y - dy, z - dz]
                            end
                            queue << i
                            all_orientations.delete(i)
                            return
                        end
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
    all_orientations = get_orientations(scanners)
    locations[0] = [0, 0, 0]
    oriented = {}
    oriented[0] = all_orientations[0][0]
    queue = []
    queue << 0
    while queue.any?
        curr = queue.shift
        find_matches(0, oriented, all_orientations, locations, queue)
    end
    locations
    # oriented[1]
#   all_orientations[0]
    # oriented[0].count
end

def day19_2
end

pp day19_1
pp day19_2