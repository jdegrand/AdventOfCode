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
    dp = {}
    $lines.map{ |l|
        row, records = l.split
        records = records.split(?,).map(&:to_i)
        recursion(0, 0, records.clone, row.clone, dp)
    }.sum
end

def day12_2
    # $lines.map{ |l|
    #     (5..5).map do |n|
    #         row, records = l.split
    #         row = ([row] * n).join("?")
    #         records = records.split(?,).map(&:to_i)
    #         new_records = []
    #         n.times{new_records.concat(records)}
    #         records = new_records
    #         recursion(0, 0, records.clone, row.clone)
    #     end
    # }.flatten.sum
end

def day12_3
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

#    ?#?#?#?#?#?#?#? 1,3,1,6
def recursion(index, count, arr, input, dp)

    #  If array is empty and there are still # left, it is not valid
    return input[index..].chars.any?("#") ? 0 : 1 if arr.empty?

    # Invalid vecause it means there are still elements left in array from above
    return 0 if index >= input.length

    # -1 means omit this character; there should be a space in between each island
    return recursion(index + 1, 0, arr, input, dp) if count == -1

    # Incomplete islands are invalid
    return count > 0 ? 0 : recursion(index + 1, 0, arr, input, dp) if input[index] == ?.

    ways = 0

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
    ways
end

# pp day12_1
pp day12_1_recursion
# pp day12_2
pp day12_3
