file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day2_1
    $lines.map{ |l| l.split.map(&:to_i) }.count{ |l| 
        (l.each_cons(2).map{| x, y | 
            (x - y).abs >= 1 && (x - y).abs <= 3
        }).all? && (l.sort == l || l.sort.reverse == l)
    }
end

def day2_2
    $lines.map{ |l| l.split.map(&:to_i) }.count{ |l| 
        valid = (l.each_cons(2)
            .map{| x, y | 
                (x - y).abs >= 1 && (x - y).abs <= 3
            }).all? && (l.sort == l || l.sort.reverse == l)
        if !valid
            (0...l.length).each{ |i|
                dl = l[0...i] + l[(i + 1)...l.length]
                valid = (dl.each_cons(2)
                    .map{| x, y | 
                        (x - y).abs >= 1 && (x - y).abs <= 3
                    }).all? && (dl.sort == dl || dl.sort.reverse == dl)
            }
        end
        valid
    }
end

pp day2_1
pp day2_2
