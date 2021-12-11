require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day11_1
    octo = Hash.new(-1)
    $lines.each_with_index do |l, r|
        l.chars.each_with_index do |o, c|
            octo[[r,c]] = o.to_i
        end
    end
    adj = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0, 0]]
    count = 0
    100.times do |t|
        octo.keys.each{|k| octo[k] += 1}
        flashed = Set.new
        nines = octo.filter{|_, v| v > 9}.map{|k, _| k}
        nines.each{|po| flashed << po}
        until nines.length == 0
            r, c = nines.shift
            adj.each do |dx, dy|
                octo[[r + dx, c + dy]] += 1 if octo[[r + dx, c + dy]] != -1
                if octo[[r + dx, c + dy]] > 9 && !flashed.include?([r + dx, c + dy])
                    flashed << [r + dx, c + dy]
                    nines << [r + dx, c + dy]
                end
            end
        end
        flashed.each{|k| octo[k] = 0}
        count += flashed.length
    end
    count
end

def day11_2
    octo = Hash.new(-1)
    $lines.each_with_index do |l, r|
        l.chars.each_with_index do |o, c|
            octo[[r,c]] = o.to_i
        end
    end
    adj = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0, 0]]
    step = 0
    while true
        octo.keys.each{|k| octo[k] += 1}
        flashed = Set.new
        nines = octo.filter{|_, v| v > 9}.map{|k, _| k}
        nines.each{|po| flashed << po}
        until nines.length == 0
            r, c = nines.shift
            adj.each do |dx, dy|
                octo[[r + dx, c + dy]] += 1 if octo[[r + dx, c + dy]] != -1
                if octo[[r + dx, c + dy]] > 9 && !flashed.include?([r + dx, c + dy])
                    flashed << [r + dx, c + dy]
                    nines << [r + dx, c + dy]
                end
            end
        end
        flashed.each{|k| octo[k] = 0}
        step += 1
        return step if flashed.length == 100
    end
end

pp day11_1
pp day11_2

