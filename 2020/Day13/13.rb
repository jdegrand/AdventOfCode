file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day13_1
    earliest = $lines[0].to_i
    buses = $lines[1].split(",").reject{|x| x == ?x}.map(&:to_i)
    times = buses.map{ |b| 
        st = b
        while st < earliest
            st += b
        end
        [st, b]
    }
    time, bus = times.min_by {|x| x[0]}
    bus * (time - earliest)
end

def day13_2
    earliest = $lines[0].to_i
    buses = $lines[1].split(",").map { |b|
        b == ?x ? -1 : b.to_i
    }
    
    curr = (100000000000000.0/buses[0]).ceil * buses[0]
    fact = buses[0]
    (1...buses.length).each do |i|
        next if buses[i] == -1
        while (curr + i) % buses[i] != 0
            curr += fact
        end
        fact *= buses[i]
    end
    curr % fact
end

puts day13_1
puts day13_2

