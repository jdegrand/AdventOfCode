file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day6_1
    fish = $lines[0].split(?,).map(&:to_i)
    80.times do
        new_fish = 0
        fish = fish.map{|f|
            new_fish += 1 if f == 0
            f == 0 ? 6 : f - 1
        }
        new_fish.times{|_| fish << 8}
    end
    fish.length
end

def day6_2
    fish = Hash.new(0)
    fishTemp = $lines[0].split(?,).map(&:to_i)
    fishTemp.each{|f| fish[f] += 1}
    256.times do
        n = 7
        last = fish[8]
        temp = -1
        until n == 0
            temp =  fish[n]
            fish[n] = last
            last = temp
            n -= 1
        end
        fish[6] += fish[0]
        fish[8] = fish[0]
        fish[0] = last
    end
    fish.values.sum
end

pp day6_1
pp day6_2

