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
            combs << temp
        end
    end
    combs
end

def get_volumes(scanner)
    Set.new(scanner.map{|x, y, z| 1/2.0 * (y - x) * z})
end

def findOverlap(s1, s2)
    to_match = Set.new(s1)
    s1.each do |r1|
        s2.each do |r2|
            dx = r1[0] - r2[0]
            dy = r1[1] - r2[1]
            dz = r1[2] - r2[2]
            matchee = Set.new(s2.map{|x, y, z| [x + dx, y + dy, z + dz]})
            common = to_match & matchee
            pp common.length
        end
    end
    # temp = scanner.sort
    # beacons.each do |x, y, z|
    #     temp.each_cons(12) do |twelve|
    #         twelve.all? do |b|
    #             beacon.include?([])
    #         end
    #     end
    # end
end

def day19_1
    scanners = []
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
   get_orientations(scanners[0])
   findOverlap(scanners[0], scanners[1])
#    temp = scanners.map{|s| get_volumes(s)}
#    temp[0] & temp[1]
end

def day19_2
end

pp day19_1
pp day19_2
