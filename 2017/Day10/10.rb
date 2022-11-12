file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day10_1
    circ = (0..255).to_a
    pos = 0
    skip_size = 0
    $lines[0].split(?,).map(&:to_i).each do |len|
        local_list = circ.rotate(pos)
        circ = (local_list[...len].reverse + local_list[len..]).rotate(-pos)
        pos += len + skip_size
        skip_size += 1
    end
    circ[0] * circ[1]
end

def day10_2
end

pp day10_1
pp day10_2
