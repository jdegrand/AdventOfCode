require 'set'

file = 'input.txt'
input = File.read(file)

lines = input.lines.map(&:chomp)

def day8_1(inst)
    acc = 0
    index = 0
    s = Set.new
    while !s.include?(index) do
        l = inst[index] 
        op, val = l.split
        case op
        when "nop"
            s << index
            index += 1
        when "acc"
            acc += val.to_i
            s << index
            index += 1
        when "jmp"
            s << index
            index = index + val.to_i
        end
    end
    acc
end

def day8_2(lines)
    lines.each_with_index do |i, ind|
        acc = 0
        index = 0
        s = Set.new
        inst = lines.map(&:clone)
        preop, preval = i.split
        if preop == "nop"
            inst[ind] = "jmp " + preval
        elsif preop == "jmp"
            inst[ind] = "nop " + preval
        end
        broken = false
        while index != inst.length do
            if s.include?(index)
                broken = true
                break
            end
            l = inst[index] 
            op, val = l.split
            case op
            when "nop"
                s << index
                index += 1
            when "acc"
                acc += val.to_i
                s << index
                index += 1
            when "jmp"
                s << index
                index = index + val.to_i
            end
        end
        if !broken
            return acc
        end
    end
    
end

puts day8_1(lines)
puts day8_2(lines)

