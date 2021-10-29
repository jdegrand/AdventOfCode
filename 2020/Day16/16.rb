require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n")

def day16_1
    rules = {}
    $lines[0].split("\n").map do |l|
        caps = l.match(/\A(\w+ ?\w+): (\d+)-(\d+) or (\d+)-(\d+)\Z/).captures
        key = caps[0] 
        l1, u1, l2, u2 = caps[1..].map(&:to_i)
        rules[key] = [(l1..u1), (l2..u2)]
    end
    e = 0
    $lines[2].split("\n")[1..].map do |l|
        tick = l.split(",").map(&:to_i)
        tick.each do |t|
            found = false
            rules.values.each do |r1, r2|
                if r1.cover?(t) || r2.cover?(t)
                    found = true
                    break
                end 
            end
            e += t if !found
        end
    end
    e
end

def day16_2
    rules = {}
    $lines[0].split("\n").map do |l|
        caps = l.match(/\A(\w+ ?\w+): (\d+)-(\d+) or (\d+)-(\d+)\Z/).captures
        key = caps[0] 
        l1, u1, l2, u2 = caps[1..].map(&:to_i)
        rules[key] = [(l1..u1), (l2..u2)]
    end
    e = 0
    tickets = []
    $lines[2].split("\n")[1..].map do |l|
        tick = l.split(",").map(&:to_i)
        all_found = []
        tick.each do |t|
            found = false
            rules.values.each do |r1, r2|
                if r1.cover?(t) || r2.cover?(t)
                    found = true
                    break
                end 
            end
            e += t if !found
            all_found << found
        end
        tickets << tick if all_found.all?
    end
    found = Hash.new([])
    rules.keys.each do |r|
        tickets[0].length.times do |i|
            valid = tickets.map{|t| t[i]}.map{|n| rules[r][0].cover?(n) || rules[r][1].cover?(n)}
            if valid.all?
                found[r] += [i]
            end
        end
    end
    found = [*found].sort_by{|k, v| v.length}
    indices = Set.new
    valid_tickets = {}
    found.each do |k, v|
        v.each do |i|
            if !indices.include?(i)
                valid_tickets[k] = i
                indices << i
                break
            end
        end
    end
    my_ticket = $lines[1].split("\n")[1].split(",").map(&:to_i)
    valid_tickets.keys.filter{|k| k.include?("departure")}.map{|d| my_ticket[valid_tickets[d]]}.reduce(:*)
end

puts day16_1
puts day16_2

