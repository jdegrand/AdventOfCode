file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day3_1
    $lines.sum{ |l|
        l.chars.combination(2).map(&:join).map(&:to_i).max
    }
end

def day3_2
    $lines.sum{ |l|
        digits_left = 12
        curr_line = l
        final_line = ""
        until digits_left == 0
            nx_ch, nx_ind = curr_line.chars.each_with_index.max_by{|n, i| n && (curr_line.length - i) >= digits_left ? n : "-1"}
            final_line << nx_ch
            curr_line = curr_line[(nx_ind + 1)..]
            digits_left -= 1
        end
        final_line.to_i
    }
end

pp day3_1
pp day3_2
