require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n")

def get_variations(s)
    vars = s.map{|x, y, z| [[x, y, z], [x, z, -y], [x, -y, -z], [x, -z, y], [-x, z, y], [-x, y, -z], [-x, -z, -y], [-x, -y, z]]}
    vars = vars.transpose
    return vars.map{|scan| Set.new(scan)}
end

def get_orientations(scanners)
    scanner_variations = {}
    scanners.each_with_index do |scanner, i|
        combs = {}
        [0,1,2].each do |v|
            s = scanner.map{|r| r.rotate(v)}
            vars = get_variations(s)
            vars.each_with_index do |set, j|
                combs[[j, v]] = set
            end
        end
        scanner_variations[i] = combs
    end
    scanner_variations
end

def overlap(combined, all_orientations, locations)
    combined.clone.each do |b|
        all_orientations.each do |i, vary|
            vary.each do |k, set|
                set.each do |beacon|
                    dx = b[0] - beacon[0]
                    dy = b[1] - beacon[1]
                    dz = b[2] - beacon[2]
                    temp = Set.new(set.map{|x, y, z| [x + dx, y +  dy, z + dz]})
                    if (combined & temp).length >= 12
                        combined.merge(temp)
                        locations[i] = [-dx, -dy, -dz]
                        all_orientations.delete(i)
                        return
                    end
                end
            end
        end
    end
end

def day19
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
    locations[0] = [0, 0, 0]
    all_orientations = get_orientations(scanners)
    combined = all_orientations[0][[0, 0]]
    all_orientations.delete(0)
    while all_orientations.keys.any?
        overlap(combined, all_orientations, locations)
        # pp all_orientations.keys.length if you want to see progress
    end
    pp combined.length
    pp locations.values.combination(2).map{|(x0, y0, z0), (x1, y1, z1)| (x1 - x0).abs + (y1 - y0).abs + (z1 - z0).abs}.max
end

day19