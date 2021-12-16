file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

BITS = {
    ?0 => "0000",
    ?1 => "0001",
    ?2 => "0010",
    ?3 => "0011",
    ?4 => "0100",
    ?5 => "0101",
    ?6 => "0110",
    ?7 => "0111",
    ?8 => "1000",
    ?9 => "1001",
    ?A => "1010",
    ?B => "1011",
    ?C => "1100",
    ?D => "1101",
    ?E => "1110",
    ?F => "1111"
}

def parse(bits, versions)
    version = bits.shift(3).join.to_i(2)
    typeID = bits.shift(3).join.to_i(2)
    versions << version
    if typeID == 4
        chunks = []
        pref, *chunk = bits.shift(5)
        chunks << chunk
        while pref == ?1
            pref, *chunk = bits.shift(5)
            chunks << chunk
        end
        return chunks.join.to_i(2)
    else
        subpackets = []
        lengthTypeID = bits.shift
        if lengthTypeID == ?0
            length = bits.shift(15).join.to_i(2)
            target_length = bits.length - length
            until bits.length == target_length
                subpackets << parse(bits, versions)
            end
        elsif lengthTypeID == ?1
            subpackets_length = bits.shift(11).join.to_i(2)
            subpackets_length.times do
                subpackets << parse(bits, versions)
            end
        end
        case typeID
        when 0
            return subpackets.sum
        when 1
            return subpackets.reduce(:*)
        when 2
            return subpackets.min
        when 3
            return subpackets.max
        when 5
            return subpackets[0] > subpackets[1] ? 1 : 0
        when 6
            return subpackets[0] < subpackets[1] ? 1 : 0
        when 7
            return subpackets[0] == subpackets[1] ? 1 : 0
        end
    end
end

def day16_1
    bits = []
    $lines[0].chars.each do |c|
        bits << BITS[c].chars
    end
    bits.flatten!
    versions = []

    parse(bits, versions)
    
    versions.sum
end

def day16_2
    bits = []
    $lines[0].chars.each do |c|
        bits << BITS[c].chars
    end
    bits.flatten!

    parse(bits, [])
end

pp day16_1
pp day16_2
