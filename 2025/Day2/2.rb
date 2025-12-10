require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day2_1
    $lines[0].split(?,).sum{ |l|
        si, ei = l.split(?-).map(&:to_i)
        repeating = Set.new
        (si..ei).each{ |n|
            ns = n.to_s
            if ns.length.even?
                repeating << n if ns[...(ns.length / 2)] == ns[(ns.length / 2)..]
            end
        }
        repeating.sum
    }
end

def day2_2
    $lines[0].split(?,).sum{ |l|
        si, ei = l.split(?-).map(&:to_i)
        repeating = Set.new
        (si..ei).each{ |n|
            nc = n.to_s.chars
            (1..(nc.length / 2)).each{ |i|
                if nc.length % i == 0 &&  nc.each_slice(i).uniq.size == 1
                    repeating << n
                    break
                end
            }
        }
        repeating.sum
    }
end

pp day2_1
pp day2_2
