file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def rec(bags, bag, memo)
    total = 0
    bags[bag].each do |b|
        if b[1] == "shiny gold"
            total += b[0]
        end
        total += memo.include?(b[1]) ? b[0] * memo[b[1]] : b[0] * rec(bags, b[1], memo)
    end
    total
end

def day7_1
    bags = {}
    $lines.map do |l|
        head = l.scan(/(\A[a-z ]+) bags /) 
        tail = l.scan(/(?: (\d+ [a-z ]+) bags?(?:,|\.))/) 
        bags[head[0][0]] = tail.map {|b|
            n, c = b[0].split(" ", 2)
            [n.to_i, c]
        }
    end
    memo = {}
    bags.each_key do |k|
        memo[k] = rec(bags,k,memo)
    end
    memo.count{|k, v| v >= 1}
end

def rec2(bags, bag)
    total = 0
    bags[bag].each do |b|
        total += b[0] + (b[0] * rec2(bags, b[1]))
    end
    total
end

def day7_2
    bags = {}
    $lines.map do |l|
        head = l.scan(/(\A[a-z ]+) bags /) 
        tail = l.scan(/(?: (\d+ [a-z ]+) bags?(?:,|\.))/) 
        bags[head[0][0]] = tail.map {|b|
            n, c = b[0].split(" ", 2)
            [n.to_i, c]
        }
    end
    
    rec2(bags, "shiny gold")
end

puts day7_1
puts day7_2

