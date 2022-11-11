file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day8_1
    registers = Hash.new(0)
    $lines.each do |l|
        target_reg, op, val, _, cond_reg, cond_op, cond = l.split
        if eval("#{registers[cond_reg]} #{cond_op} #{cond}")
            registers[target_reg] += op == "inc" ? val.to_i : (-1 * val.to_i)
        end
    end
    registers.values.max
end

def day8_2
    registers = Hash.new(0)
    max = 0
    $lines.each do |l|
        target_reg, op, val, _, cond_reg, cond_op, cond = l.split
        if eval("#{registers[cond_reg]} #{cond_op} #{cond}")
            registers[target_reg] += op == "inc" ? val.to_i : (-1 * val.to_i)
            max = [max, registers[target_reg]].max
        end
    end
    max
end

pp day8_1
pp day8_2
