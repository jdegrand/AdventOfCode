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
         _, *a = bits.shift(5)
        _, *b = bits.shift(5)
        _, *c = bits.shift(5)
        bits.shift(3)
        # pp (a + b + c).join.to_i(2)
    else
        lengthTypeID = bits.shift
        if lengthTypeID == ?0
            length = bits.shift(15).join.to_i(2)
            # pp length
            target_length = bits.length - length
            # pp target_length
            # pp bits.length
            until bits.length >= target_length
                # pp "#{length}, #{bits.length}, #{target_length}"
                parse(bits, versions)
            end
        elsif lengthTypeID == ?1
            subpackets = bits.shift(11).join.to_i(2)
            # pp subpackets
            subpackets.times do
                parse(bits, versions)
            end
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
    while bits.any?
       parse(bits, versions)
    end
    versions.sum
end

def day16_2
end

pp day16_1
pp day16_2

