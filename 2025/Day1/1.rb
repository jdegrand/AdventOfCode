file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day1_1
    zero_count = 0
    $lines.reduce(50){ |dial, l| 
        dir = l[0]
        val = l[1..].to_i
        nv = (dial + (dir == ?L ? val * -1 : val)) % 100
        zero_count += 1 if nv == 0
        nv
    }
    zero_count
end

def day1_2
    zero_count = 0
    $lines.reduce(50){ |dial, l| 
        dir = l[0]
        val = l[1..].to_i
        rotations, rem = val.divmod(100)
        if rem < 100
            if dir == ?L
            zero_count += 1 if dial - rem <= 0 && dial != 0
            else
            zero_count += 1 if dial + rem >= 100
            end
        end
        zero_count += rotations
        (dial + (dir == ?L ? val * -1 : val)) % 100
    }
    zero_count
end

pp day1_1
pp day1_2
