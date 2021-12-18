file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def explode(nums, l, r, i, loc)
    if loc == :right    # Pair is on right
        # [7,[6,[5,[4,[3,2]]]]]
        if i + 2 < nums.length
            to_change, to_change_depth = nums[i + 2]
            nums[i + 2] = [r[0] + to_change, to_change_depth]
        end
        new_l = l[0] + nums[i - 1][0]
        nums[i - 1] = [new_l, nums[i - 1][1]]
        nums[i + 1] = [0, r[1] - 1]
        nums.delete_at(i)
    elsif loc == :left   # Pair is on left
        # [[[[[9,8],1],2],3],4]
        if i > 0
            to_change, to_change_depth = nums[i - 1]
            nums[i - 1] = [l[0] + to_change, to_change_depth]
        end
        new_r = r[0] + nums[i + 2][0]
        nums[i] = [0, l[1] - 1]
        nums[i + 2] = [new_r,  nums[i + 2][1]]
        nums.delete_at(i + 1)
    end
end

def reduce(nums)
    nums.each_cons(2).to_a.each_with_index do |(l, r), i|
        pp "#{l}, #{r}"
        if l[0] >= 10
            new_l = [(l[0]/2.0).floor, l[1] + 1]
            new_r = [(l[0]/2.0).ceil, l[1] + 1]
            new_d = l[1] + 1
            nums[i] = new_l
            nums.insert(i + 1, new_r)
            explode(nums, new_l, new_r, i, :left) if new_d > 4
            return
        elsif r[0] >= 10
            new_l = [(r[0]/2.0).floor, r[1] + 1]
            new_r = [(r[0]/2.0).ceil, r[1] + 1]
            new_d = r[1] + 1
            nums[i + 1] = new_l
            nums.insert(i + 2, new_r)
            explode(nums, new_l, new_r, i + 1, :right) if new_d > 4
            return
        elsif l[1] == 5 && r[1] == 5
            if i > 0 && nums[i - 1][1] >= 4     # Pair is on right
                explode(nums, l, r, i, :right)
                return
            elsif i < nums.length && nums[i + 2][1] >= 4 # Pair is on left
                explode(nums, l, r, i, :left)
                return
            end
        end
    end
end

def magnitude(nums)
    max = nums.max_by{|_, d| d}[1]
    inner_nums = nums.each.with_index.filter do |(_, d), _|
        d == max
    end
    inner_nums.each_cons(2) do |((n1, d1), i1), ((n2, d2), i2)|
        if i2 - 1 == i1
            nums[i1] = [3 * n1 + 2 * n2, d1 - 1]
            nums.delete_at(i2)
            return
        end
    end
end

def string_to_nums(nums, prob)
    depth = 0
    prob.chars.each do |c|
        case c
        when ?[
            depth += 1
        when ?]
            depth -= 1
        when ?,
            next
        else
            nums << [c.to_i, depth]
        end
    end
end

def reduceAll(nums)
    changed = true
    last_length = nums.length
    while changed
        reduce(nums)
        changed = last_length != nums.length
        last_length = nums.length
    end
end

def day18_1
    problems = []
    prob = $lines[0]
    nums = []
    string_to_nums(nums, prob)
    reduceAll(nums)
    $lines[1..].each do |l|
        last_nums = nums
        nums = []
        string_to_nums(nums, l)
        reduceAll(nums)
        nums = last_nums.map{|n, d| [n, d + 1]} + nums.map{|n, d| [n, d + 1]}
        reduceAll(nums)
    end
    pp nums
    while nums.length > 1
        magnitude(nums)
    end
    nums
end

def day18_2
end

pp day18_1
pp day18_2