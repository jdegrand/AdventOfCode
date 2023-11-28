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


# def day7_1
#     wires = Hash.new(0)
#     $lines.each do |l|
#         if l =~ $ops[:set]
#             val, wire = l.match($ops[:set]).captures
#             wires[wire] = get_val(val, wires)
#         elsif l =~ $ops[:and]
#             val1, val2, wire = l.match($ops[:and]).captures
#             wires[wire] = get_val(val1, wires) & get_val(val2, wires)
#         elsif l =~ $ops[:or]
#             val1, val2, wire = l.match($ops[:or]).captures
#             wires[wire] = get_val(val1, wires) | get_val(val2, wires)
#         elsif l =~ $ops[:lshift]
#             val1, val2, wire = l.match($ops[:lshift]).captures
#             wires[wire] = get_val(val1, wires) << val2.to_i
#         elsif l =~ $ops[:rshift]
#             val1, val2, wire = l.match($ops[:rshift]).captures
#             wires[wire] = get_val(val1, wires) >> val2.to_i
#         elsif l =~ $ops[:not]
#             val, wire = l.match($ops[:not]).captures
#             val = get_val(val, wires)
#             puts "her", val
#             val = "0b#{val.to_s(2).rjust(16, "0").chars.map{|c| c == ?0 ? ?1 : ?0}.join}".to_i(2)
#             wires[wire] = val
#         end
#     end
#     wires
# end

def day7_1
    wires = Hash.new(0)
    $lines.each do |l|
        if l =~ $ops[:set]
            val, wire = l.match($ops[:set]).captures
            wires[wire] = val
        elsif l =~ $ops[:and]
            val1, val2, wire = l.match($ops[:and]).captures
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
            val = get_val(val, wires)
            puts "her", val
            val = "0b#{val.to_s(2).rjust(16, "0").chars.map{|c| c == ?0 ? ?1 : ?0}.join}".to_i(2)
            wires[wire] = val
        end
    end
    wires
end

def day7_2
end

pp day7_1
pp day7_2
