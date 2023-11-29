require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def backtracking(location, from_to, visited, all_locations, total_distance)
    if visited == all_locations
        return [total_distance]
    end
    to_visit = from_to[location].each.reject{|l, _| visited.include?(l)}
    if to_visit.size == 0
       return [Float::INFINITY]
    end
    solutions = []
    to_visit.each do |next_location, distance|
        visited << next_location
        solutions += backtracking(next_location, from_to, visited, all_locations, total_distance + distance)
        visited.delete(next_location)
    end
    solutions
end

def day9_1
    reg = /(\w+) to (\w+) = (\d+)/
    all_locations = Set.new
    from_to = Hash.new([])
    $lines.each do |l|
        l.scan(reg)
        all_locations << $1 << $2
        from_to[$1] += [[$2, $3.to_i]]
        from_to[$2] += [[$1, $3.to_i]]
    end
    solutions = []
    all_locations.each do |location|
        visited = Set.new
        visited << location
        solutions += backtracking(location, from_to, visited, all_locations, 0)
    end
    solutions.min
end

def day9_2
    reg = /(\w+) to (\w+) = (\d+)/
    all_locations = Set.new
    from_to = Hash.new([])
    $lines.each do |l|
        l.scan(reg)
        all_locations << $1 << $2
        from_to[$1] += [[$2, $3.to_i]]
        from_to[$2] += [[$1, $3.to_i]]
    end
    solutions = []
    all_locations.each do |location|
        visited = Set.new
        visited << location
        solutions += backtracking(location, from_to, visited, all_locations, 0)
    end
    solutions.max
end

pp day9_1
pp day9_2
