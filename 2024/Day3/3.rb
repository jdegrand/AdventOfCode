file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day3_1
    reg = /mul\(\d{1,3},\d{1,3}\)/
    matches = $lines.join.scan(reg)
    matches.map{|m| m[4...(m.length - 1)].split(?,).map(&:to_i).inject(:*)}.sum
end

def day3_2
    reg = /mul\(\d{1,3},\d{1,3}\)/
    do_dont_reg = /(?=(do\(\)|don't\(\)))/
    splits = $lines.join.split(do_dont_reg)
    do_on = true
    total = 0
    splits.each{ |s|
        next if !do_on && s != "do()"
        if s == "do()"
            do_on = true
        elsif s == "don't()"
            do_on = false
        else
            matches = s.scan(reg)
            total += matches.map{|m| m[4...(m.length - 1)].split(?,).map(&:to_i).inject(:*)}.sum
        end
    }
    total
end

pp day3_1
pp day3_2
