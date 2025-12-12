file = 'input.txt'
$input = File.read(file)

def day5_1
    fresh_range, ing_list = $input.split("\n\n")
    fresh_range = fresh_range.lines
    fresh_range.map!{ |range|
        l, r = range.chomp.split(?-).map(&:to_i)
        (l..r)
    }
    fresh_range

    ing_list.lines.map(&:chomp).count{ |ing| fresh_range.any?{ _1.cover?(ing.to_i) } }
end

def day5_2
    fresh_range, _ = $input.split("\n\n")
    fresh_range = fresh_range.lines
    fresh_range.map!{ |range|
        l, r = range.chomp.split(?-).map(&:to_i)
        (l..r)
    }
    fresh_range.sort_by!(&:first)
    ranges_length = fresh_range.length
    current_index = 1
    until current_index >= ranges_length
        lrange, rrange = fresh_range[(current_index - 1)..current_index]
        if lrange.overlap?(rrange)
            fresh_range[current_index - 1] = (lrange.first..([lrange.last, rrange.last].max))
            fresh_range.delete_at(current_index)
            ranges_length -= 1
        else
            current_index += 1
        end
    end
    fresh_range.sum(&:size)
end

pp day5_1
pp day5_2
