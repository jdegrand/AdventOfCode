file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day23_1
    registers = Hash.new(0)
    instruction = 0
    mul_count = 0
    until instruction >= $lines.size
        op, p1, p2 = $lines[instruction].split
        p1_is_int = /\A[-+]?\d+\z/.match(p1)
        p2 = /\A[-+]?\d+\z/.match(p2) ? p2.to_i : registers[p2]
        case op
        when 'set'
            registers[p1] = p2
        when 'sub'
            registers[p1] -= p2
        when 'mul'
            mul_count += 1
            registers[p1] *= p2
        when 'mod'
            registers[p1] %= p2
        when 'jnz'
            instruction += (p1_is_int ? p1.to_i : registers[p1]) != 0 ? p2 : 1
            next
        else
            raise 'Double parameters not matched!'
        end
        instruction += 1
    end
    mul_count
end


def day23_2
    registers = Hash.new(0)
    registers[?a] = 1
    instruction = 0
    mul_count = 0
    until instruction >= $lines.size
        op, p1, p2 = $lines[instruction].split
        p1_is_int = /\A[-+]?\d+\z/.match(p1)
        p2 = /\A[-+]?\d+\z/.match(p2) ? p2.to_i : registers[p2]
        case op
        when 'set'
            registers[p1] = p2
        when 'sub'
            registers[p1] -= p2
        when 'mul'
            mul_count += 1
            registers[p1] *= p2
        when 'mod'
            registers[p1] %= p2
        when 'jnz'
            # pp p1
            # pp (p1_is_int ? p1.to_i : registers[p1])
            instruction += (p1_is_int ? p1.to_i : registers[p1]) != 0 ? p2 : 1
            next
        else
            raise 'Double parameters not matched!'
        end
        instruction += 1
        # pp instruction
    end
    mul_count
end

pp day23_1
pp day23_2
