file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day13_1
    # depth: [range, scanner_position, direction]
    firewall = {}
    $lines.each do |l|
        depth, range = l.split(": ").map(&:to_i)
        firewall[depth] = [range, 0, 1]
    end

    caught = []
    (0..firewall.keys.last).each do |step|
        caught << step if firewall[step] && firewall[step][1] == 0
        firewall.each do |depth, (range, s_pos, dir)|
            if dir == 1 && s_pos + 1 == range
                firewall[depth] = [range, s_pos - 1, -1]
            elsif dir == -1 && s_pos - 1 < 0
                firewall[depth] = [range, s_pos + 1, 1]
            else
                firewall[depth] = [range, s_pos + dir, dir]
            end
        end
    end

    caught.map{|depth| depth * firewall[depth][0]}.sum
end

def day13_2
    firewall = {}
    $lines.each do |l|
        depth, range = l.split(": ").map(&:to_i)
        firewall[depth] = range
    end

    cannot_be = {}
    firewall.each{|depth, range| cannot_be[depth] = (range - 1) * 2}

    0.step do |s|
        break s if cannot_be.none?{|depth, invalid| (s + depth) % invalid == 0}
    end
end

pp day13_1
pp day13_2
