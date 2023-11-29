file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

$ops = {
    :set => /^(\d+) -> (\w+)$/,
    :and => /^(\w+) AND (\w+) -> (\w+)$/,
    :or => /^(\w+) OR (\w+) -> (\w+)$/,
    :lshift => /^(\w+) LSHIFT (\d+) -> (\w+)$/,
    :rshift => /^(\w+) RSHIFT (\d+) -> (\w+)$/,
    :not => /^NOT (\w+) -> (\w+)$/
}.freeze

def get_val(key, wires)
    key =~ /\d+/ ? key.to_i : wires[key]
end

def is_num?(key)
    key =~ /\d+/
end 

def day7_1
    wires = {}
    relies_on = Hash.new([])
    $lines.each do |l|
        if l =~ $ops[:set]
            val, wire = l.match($ops[:set]).captures
            wires[wire] = val
        elsif l =~ $ops[:and]
            val1, val2, wire = l.match($ops[:and]).captures
            relies_on << val1 if !is_num?(val1)
            relies_on << val2 if !is_num?(val2)
            wires[wire] = get_val(val1, wires) & get_val(val2, wires)
        elsif l =~ $ops[:or]
            val1, val2, wire = l.match($ops[:or]).captures
            wires[wire] = get_val(val1, wires) | get_val(val2, wires)
        elsif l =~ $ops[:lshift]
            val1, val2, wire = l.match($ops[:lshift]).captures
            wires[wire] = get_val(val1, wires) << val2.to_i
        elsif l =~ $ops[:rshift]
            val1, val2, wire = l.match($ops[:rshift]).captures
            wires[wire] = get_val(val1, wires) >> val2.to_i
        elsif l =~ $ops[:not]
            val, wire = l.match($ops[:not]).captures
            val = get_val(val)
            wires[wire] = ~val if val
        end
    end
    wires
end

def day7_2
end

pp day7_1
pp day7_2
