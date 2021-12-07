file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day7_1
    fuels = Hash.new(0)
    subs = $lines[0].split(?,).map(&:to_i)
    l, r = subs.minmax
    (l..r).each do |x|
        subs.each do |s|
            fuels[x] += (x - s).abs
        end
    end
    fuels.values.min
end

def day7_2
    fuels = Hash.new(0)
    subs = $lines[0].split(?,).map(&:to_i)
    l, r = subs.minmax
    (l..r).each do |x|
        subs.each do |s|
            fuels[x] += (1..(x - s).abs).inject(:+) || 0
        end
    end
    fuels.values.min
end

pp day7_1
pp day7_2

