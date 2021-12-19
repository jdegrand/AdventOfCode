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

def findOverlap(beacons, scanner)
    temp = scanner.sort
    beacons.each do |x, y, z|
        temp.each_cons(12) do |twelve|
            twelve.all? do |b|
                beacon.include?([])
            end
        end
    end
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
   temp = scanners.map{|s| get_volumes(s)}
   temp[0] & temp[1]
end

def day19_2
end

pp day19_1
pp day19_2
