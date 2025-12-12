file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day6_1
    $lines.map(&:split).transpose.sum{ _1[0...-1].map(&:to_i).inject( _1.last == ?* ? :* : :+)}
end

def day6_2
    ops = []
    current_op = [$lines[-1].chars[0], 0]
    $lines[-1][1..].chars.each_with_index{ |ch, i|
        if ch != " "
            ops << [current_op.first, i - current_op.last]
            current_op = [ch, i + 1]
        end
    }
    ops << [current_op.first, $lines[-1].length - current_op.last]
    $lines[0...-1].map{ |l|
        nums = []
        ind = 0
        ops.each{ |(_, num_length)|
            nums << l[ind...(ind + num_length)]
            ind += num_length + 1
        }
        nums
    }.transpose.each_with_index.sum{ |nums, index|
        nums.map(&:chars).transpose.map{ _1.join.to_i }.inject(ops[index].first == ?* ? :* : :+)
    }
end

pp day6_1
pp day6_2
