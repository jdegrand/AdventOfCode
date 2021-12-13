require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day12_1
    paths = Hash.new([])
    count = 0
    $lines.each do |l|
        c1, c2 = l.split(?-)
        paths[c1] += [c2]
        paths[c2] += [c1]
    end
    stack = [["start"]]
    visited = Set.new
    while stack.any?
        curr = stack.shift
        visited << curr
        paths[curr[0]].each do |c|
            if c == "end"
                count += 1
            elsif !visited.include?([c] + curr) && !(c == c.downcase && curr.include?(c))
                nex = [c] + curr
                stack.unshift(nex)
            end
        end
    end
    count
end

def day12_2
    paths = Hash.new([])
    count = 0
    small_caves = Set.new
    $lines.each do |l|
        c1, c2 = l.split(?-)
        paths[c1] += [c2]
        paths[c2] += [c1]
        small_caves << c1 if c1 == c1.downcase
        small_caves << c2 if c2 == c2.downcase
    end
    small_caves -= Set.new(["start", "end"])
    paths_set = Set.new
    small_caves.each do |sc|
        stack = [["start"]]
        visited = Set.new
        while stack.any?
            curr = stack.shift
            visited << curr
            paths[curr[0]].each do |c|
                if c == "end"
                    count += 1 if !paths_set.include?(curr)
                    paths_set << curr
                elsif !visited.include?([c] + curr)
                    if c == sc && curr.count(sc) <= 1 || !(c == c.downcase && curr.include?(c))
                        nex = [c] + curr
                        stack.unshift(nex)
                    end
                end
            end
        end
    end
    count
end

pp day12_1
pp day12_2
