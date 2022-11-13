class KnotHash
    def initialize(prehash)
        @prehash = prehash
    end

    def knot_helper(circ, lengths, starting_pos, starting_skip)
        pos = starting_pos
        skip_size = starting_skip
        lengths.each do |len|
            local_list = circ.rotate(pos)
            circ = (local_list[...len].reverse + local_list[len..]).rotate(-pos)
            pos += len + skip_size
            skip_size += 1
        end
        return circ, pos, skip_size
    end

    def hash
        lengths = @prehash.codepoints + [17, 31, 73, 47, 23]
        sequence = (0..255).to_a
        pos = 0
        skip_size = 0
        64.times do
            sequence, pos, skip_size = knot_helper(sequence, lengths, pos, skip_size)
        end
        sequence.each_slice(16).map{|slice| slice.inject(:^)}.map{|xor| xor.to_s(16).rjust(2, "0")}.join
    end
end