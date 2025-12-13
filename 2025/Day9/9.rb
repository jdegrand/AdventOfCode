require 'Set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day9_1
    red = $lines.map{ _1.split(?,).map(&:to_i) }
    red.combination(2).map{ _1.zip(_2).map{ |n1, n2| (n1 - n2).abs + 1}.inject(:*) }.max
end

def day9_2
    reds = $lines.map{ _1.split(?,).map(&:to_i) }
    greens = Set.new
    test = Hash.new([])
    filled = Set.new
    test2 = Hash.new([])
    reds.each_with_index{ |point, i|
        prev_point = reds[i - 1]
        xs = [prev_point.first, point.first].sort
        ys = [prev_point.last, point.last].sort
        if ys.inject(:-) == 0
            test2[ys[0]] += [(xs.first..xs.last)]
        else
            (ys.first..ys.last).each{ test2[_1] += [(xs.first..xs.last)]}
        end
    }

    # Combine overlapping ranges
    test2.each{ |k, v|
        ranges = v.sort_by!(&:first)
        ranges_length = ranges.length
        current_index = 1
        until current_index >= ranges_length
            lrange, rrange = ranges[(current_index - 1)..current_index]
            if lrange.overlap?(rrange)
                ranges[current_index - 1] = (lrange.first..([lrange.last, rrange.last].max))
                ranges.delete_at(current_index)
                ranges_length -= 1
            else
                current_index += 1
            end
        end

        # (2..5), (7..9), (11..11)
        # (2..9), (11..11)
        index = 1
        while index < ranges.length
            r1 = ranges[index - 1]
            r2 = ranges[index]
            ranges[index - 1] = (r1.first..r2.last)
            ranges.delete_at(index)
            index += 1 if r2.size == 1
        end
        # ranges = ranges.each_slice(2).map{ |r1, r2|
        #     next r1 unless r2
        #     r1.first..r2.last
        # }
        test2[k] = ranges
    }

    final = 0

    reds.combination(2).each{ |r1, r2|
        x1, y1 = r1
        x2, y2 = r2

        if test2[y1].any?{ _1.cover?(x1) && _1.cover?(x2)} && test2[y2].any?{ _1.cover?(x1) && _1.cover?(x2)}
             final = [r1.zip(r2).map{ |n1, n2| (n1 - n2).abs + 1}.inject(:*), final].max
        end
    }
    final
end

pp day9_1
pp day9_2
