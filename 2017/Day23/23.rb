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
    a, b, c, d, e, f, g, h = 1, 0, 0, 0, 0, 0, 0, 0
    b = 105700
    c = 122700
    loop do
        f = 1
        d = 2
        loop do
            e = 2
            broken = loop do
                g = (d * e) - b
                if g == 0
                    f = 0
                    break :broke
                end
                e += 1
                g = e - b
                if g == 0
                    break
                end
            end
            break if broken == :broke
            d += 1
            g = d - b
            if g == 0
                break
            end
        end
        if f == 0
            h += 1
        end
        g = b - c
        if g == 0
            break
        end
        b += 17
    end
end

pp day23_1
pp day23_2
