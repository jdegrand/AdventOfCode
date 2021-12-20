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
            [-1, 1].product([-1, 1], [-1, 1]) do |dx, dy, dz|
                temp = Set.new(s.map{|x, y, z| [x * dx, y * dy, z * dz]})
                combs[[[dx, dy, dz], v]] = temp
            end
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
    b = oriented[id].to_a[0]
    pp "Testing id #{id}"
    all_orientations.each do |i, vals|
        next if id == i
        next if locations.keys.include?(i)
        pp "IDD: #{id} #{i}"
        vals.each do |diff, set|
            break if locations.keys.include?(i)
            set.each do |beacon|
                pp oriented[id]
                return
                dx = b[0] + beacon[0]
                dy = b[1] + beacon[1]
                dz = b[2] + beacon[2]
                temp = Set.new(set.map{|x, y, z| [x - dx, y - dy, z - dz]})
                if (oriented[id] & temp).length >= 12
                    locations[i] = [locations[id][0] + dx, locations[id][1] + dy, locations[id][2] + dz]
                    oriented[i] = set
                    queue << i
                    break
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
    oriented[0] = all_orientations[0][[[1, 1, 1], 0]]
    queue = []
    queue << 0
    while queue.any?
        curr = queue.shift
        pp curr
        find_matches(curr, oriented, all_orientations, locations, queue)
    end
    locations
    oriented[1]
#   all_orientations[0]
end

def day19_2
end

pp day19_1
pp day19_2