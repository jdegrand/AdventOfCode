file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def explode(nums, l, r, i)
    if i > 0
        to_change, to_change_depth = nums[i - 1]
        nums[i - 1] = [l[0] + to_change, to_change_depth]
    end
    if i + 2 < nums.length
        to_change, to_change_depth = nums[i + 2]
        nums[i + 2] = [r[0] + to_change, to_change_depth]
    end
    nums[i] = [0, l[1] - 1]
    nums.delete_at(i + 1)
end

def reduce(nums)
    nums.each_cons(2).to_a.each_with_index do |(l, r), i|
        if l[1] == 5 && r[1] == 5
            explode(nums, l, r, i)
            return
        end
    end
    nums.each_cons(2).to_a.each_with_index do |(l, r), i|
        if l[0] >= 10
            new_l = [(l[0]/2.0).floor, l[1] + 1]
            new_r = [(l[0]/2.0).ceil, l[1] + 1]
            nums[i] = new_l
            nums.insert(i + 1, new_r)
            return
        end
    end
    if nums[-1][0] >= 10
        r = nums[-1]
        new_l = [(r[0]/2.0).floor, r[1] + 1]
        new_r = [(r[0]/2.0).ceil, r[1] + 1]
        nums[-1] = new_l
        nums << new_r
        return
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
    last_nums = nums.map(&:clone)
    while changed
        reduce(nums)
        changed = last_nums != nums
        last_nums = nums.map(&:clone)
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
    while nums.length > 1
        magnitude(nums)
    end
    nums[0][0]
end

def day18_2
    mags = []
    $lines.permutation(2).each do |l1, l2|
        nums1 = []
        string_to_nums(nums1, l1)
        reduceAll(nums1)
        nums2 = []
        string_to_nums(nums2, l2)
        reduceAll(nums2)
        nums = nums1.map{|n, d| [n, d + 1]} + nums2.map{|n, d| [n, d + 1]}
        reduceAll(nums)
        while nums.length > 1
            magnitude(nums)
        end
        mags << nums[0][0]
    end
    mags.max
end

pp day18_1
pp day18_2
