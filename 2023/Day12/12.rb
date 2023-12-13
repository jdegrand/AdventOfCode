file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

# Original Attempt - Worked For Part 1
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

# Second Attempt - Using Recursion
def day12_1_recursion
    $lines.map{ |l|
        row, records = l.split
        records = records.split(?,).map(&:to_i)
        dp = {}
        recursion(0, 0, records.clone, row.clone, dp)
    }.sum
end

# Legacy: Worked for examples but not for my input
def day12_2_legacy
    $lines.map{ |l|
        (1..2).map do |n|
            dp = {}
            row, records = l.split
            row = ([row] * n).join("?")
            records = records.split(?,).map(&:to_i)
            new_records = []
            n.times{new_records.concat(records)}
            records = new_records
            recursion(0, 0, records.clone, row.clone, dp)
        end
    }.map{_1 * ((_2 / _1) ** 4)}.sum
end

def day12_2
    n = 5
    $lines.map{ |l|
        row, records = l.split
        row = ([row] * n).join("?")
        records = records.split(?,).map(&:to_i)
        new_records = []
        n.times{new_records.concat(records)}
        records = new_records
        dp = {}
        recursion(0, 0, records.clone, row.clone, dp)
    }.sum
end

def recursion(index, count, arr, input, dp)
    return dp[[index, count, arr]] if dp.key?([index, count, arr])
    ways = 0
    #  If array is empty and there are still # left, it is not valid
    if arr.empty?
        ways = input[index..].chars.any?("#") ? 0 : 1
    # Invalid vecause it means there are still elements left in array from above
    elsif index >= input.length
        ways = 0 
    # -1 means omit this character; there should be a space in between each island
    elsif count == -1
        ways = recursion(index + 1, 0, arr, input, dp)
    # Incomplete islands are invalid
    elsif input[index] == ?.
        ways = count > 0 ? 0 : recursion(index + 1, 0, arr, input, dp)
    else
        # Take the path (You have to if it is a #)
        if count + 1 == arr.first && (index + 1 >= input.length ? true : input[index + 1] != "#")
            # Path is taken and it completes the island
            ways += recursion(index + 1, -1, arr[1..], input, dp)
        else
            # Path is taken and it does not complete the island
            ways += recursion(index + 1, count + 1, arr, input, dp)
        end

        # Don't take the path (Only if ?)
        # If count > 0, this means an island is not accounted for and therefore invalid
        ways += recursion(index + 1, 0, arr, input, dp) if input[index] == "?" if count == 0
    end
    dp[[index, count, arr]] = ways
    ways
end

pp day12_1_recursion
pp day12_2
