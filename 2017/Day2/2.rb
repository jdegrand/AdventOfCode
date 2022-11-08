file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp).map{|l| l.split.map(&:to_i)}

def day2_1
    ($lines.map do |l|
        min, max = l.minmax
        max - min
    end).sum
end

def day2_2
    ($lines.map do |l|
        divs = []
        l.each_with_index do |outer, i|
            l.each_with_index do |inner, j|
                divs << outer.to_f / inner unless i == j
            end
        end
        divs.detect{|f| f == f.to_i}
    end).sum.to_i
end

pp day2_1
pp day2_2
