file = 'input.txt'
input = File.read(file)

$lines = input

def parse(packet, i)
    ls = []
    while i < packet.length
        case packet[i]
        when "["
            new_ls, new_index = parse(packet, i + 1)
            ls << new_ls
            i = new_index
        when "]"
            return [ls, i]
        when ","
        else
            begin_index = i
            while i + 1 < packet.length && packet[i + 1].match?(/\d/)
                i += 1
            end
            ls << packet[begin_index..i].to_i
        end
        i += 1
    end
    return ls[0]
end

def get_ordered(left_ls, right_ls, index)
    if left_ls[index] == nil && right_ls[index] != nil
        return [true, false]
    elsif left_ls[index] != nil && right_ls[index] == nil
        return [false, false]
    elsif left_ls[index] == nil && right_ls[index] == nil
        return [false, true]
    elsif left_ls[index].is_a?(Integer) && right_ls[index].is_a?(Integer)
        l, r = left_ls[index].to_i, right_ls[index].to_i
        return [true, false] if l < r
        return [false, false] if l > r
        return get_ordered(left_ls, right_ls, index + 1)
    elsif left_ls[index].is_a?(Integer) && !right_ls[index].is_a?(Integer)
        result, cont = get_ordered([left_ls[index]], right_ls[index], 0)
        return get_ordered(left_ls, right_ls, index + 1) if cont
        return [result, false]
    elsif !left_ls[index].is_a?(Integer) && right_ls[index].is_a?(Integer)
        result, cont = get_ordered(left_ls[index], [right_ls[index]], 0)
        return get_ordered(left_ls, right_ls, index + 1) if cont
        return [result, false]
    else
        result, cont = get_ordered(left_ls[index], right_ls[index], 0)
        return get_ordered(left_ls, right_ls, index + 1) if cont
        return [result, false]
    end
end

def day13_1
    pairs = $lines.split("\n\n")
    pairs = pairs.map do |pair|
        left, right = pair.lines.map(&:chomp)
        left_ls = parse(left, 0)
        right_ls = parse(right, 0)
        [left_ls, right_ls]
    end
    (pairs.filter_map.with_index do |(left_ls, right_ls), i|
        i + 1 if get_ordered(left_ls, right_ls, 0)[0]
    end).sum
end

def day13_2
    pairs = $lines.split("\n\n")
    packets = []
    pairs.each do |pair|
        left, right = pair.lines.map(&:chomp)
        left_ls = parse(left, 0)
        right_ls = parse(right, 0)
        packets << left_ls
        packets << right_ls
    end
    added_packets = [[[2]], [[6]]]
    added_packets.each{|packet| packets << packet}
    packets.sort!{|x, y| get_ordered(y, x, 0)[0].to_s <=> get_ordered(x, y, 0)[0].to_s}
    added_packets.map{|packet| packets.index(packet) + 1}.reduce(:*)
end

pp day13_1
pp day13_2
