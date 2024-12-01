file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day1_1
    l, r = $lines.map{ |l| l.split.map(&:to_i) }.transpose.map{ |t| t.sort}
    l.zip(r).map{|x, y| (x - y).abs}.sum
end

def day1_2
    l, r = $lines.map{ |l| l.split.map(&:to_i) }.transpose
    tally = r.tally(Hash.new(0))
    l.map{ |x| x * tally[x] }.sum
end

pp day1_1
pp day1_2
