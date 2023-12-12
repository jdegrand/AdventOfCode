file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day12_1
    $lines.map{ |l|
        row, records = l.split
        records = records.split(?,).map(&:to_i)
        present = row.count(?#)
        combs = records.sum - present
        row.chars.each_with_index.filter_map{ _2 if _1 == '?' }.combination(combs).filter { |comb|
            temp_row = row.clone
            comb.each{ temp_row[_1] = ?#}
            temp_row.split(/\.|\?/).reject(&:empty?).map(&:length) == records
        }.length
    }.sum
end

def day12_2()
    count = 0
    $lines.map{ |l|
        count += 1
        (1..2).map do |n|
            row, records = l.split
            row = ([row] * n).join("?")
            records = records.split(?,).map(&:to_i)
            new_records = []
            n.times{new_records.concat(records)}
            records = new_records
            present = row.count(?#)
            combs = records.sum - present
            row.chars.each_with_index.filter_map{ _2 if _1 == '?' }.combination(combs).filter { |comb|
                temp_row = row.clone
                comb.each{ temp_row[_1] = ?#}
                temp_row.split(/\.|\?/).reject(&:empty?).map(&:length) == records
            }.length
        end
    }.map{_1 * ((_2 / _1) ** 4)}.sum
end

pp day12_1
pp day12_2
