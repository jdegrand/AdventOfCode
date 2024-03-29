require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

$valid_vars = Set.new([?w, ?x, ?y, ?z])

def get_val(arg, vars)
    $valid_vars.include?(arg) ? vars[arg] : arg.to_i
end

def execute(num)
    num_s = num.to_s
    return false if num_s.include?(?0)
    num_index = 0
    vars = Hash.new(0)
    $lines.each do |l|
        inst, a, b = l.split
        b = get_val(b, vars) if b
        case inst
        when "inp"
            vars[a] = num_s[num_index].to_i
            num_index += 1
        when "add"
            vars[a] += b
        when "mul"
            vars[a] *= b
        when "div"
            vars[a] = vars[a] / b
        when "mod"
            vars[a] %= b
        when "eql"
            vars[a] = vars[a] == b ? 1 : 0
        end
    end
    vars["z"] == 0 ? true : false 
end

def day24_1
    largest = 89913949293989
    largest if execute(largest)
end

def day24_2
    smallest = 12911816171712
    smallest if execute(smallest)
end

pp day24_1
pp day24_2
