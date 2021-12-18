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
        nums[i - 1] = [new_l, nums[i - 1][0]]
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
        if l[1] == 5 && r[1] == 5
            if i > 0 && nums[i - 1][1] == 4     # Pair is on right
                explode(nums, l, r, i, :right)
                return
            elsif i < nums.length && nums[i + 2][1] == 4 # Pair is on left
                explode(nums, l, r, i, :left)
                return
            end
        elsif l[0] >= 10
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
        end
    # elsif l[0] >= 10 || r[0] >= 10
        # new_l = l[0] >= 10 ? [(l[0]/2.0).floor, l[1] + 1] : [(r[0]/2.0).floor, r[1] + 1]
        # new_r = l[0] >= 10 ? [(l[0]/2.0).ceil, l[1] + 1] : [(r[0]/2.0).ceil, r[1] + 1]
        # new_d = l[0] >= 10 ? l[1] + 1 : r[1] + 1
        # nums[i] = new_l
        # nums.insert(i + 1, [new_r, new_d])
        # if new_d == 5 && i > 0 && nums[i - 1][1] == 4
        #     explode(nums, new_l, new_r, i, :right) 
        # elsif new_d == 5 && i < nums.length && nums[i + 2][1] == 4
        #     explode(nums, new_l, new_r, i, :left) 
        # end
        # return
    # end
    end
end

def reconstruct_string(nums)
    depth = 0
    res = ""
    nums.each_with_index do |(n, d), i|
        if i % 2 != 0 && d > depth
            res +=
    end
end

# def reconstruct_string(nums, i, depth)
#     if nums[i][1] == nums[i+1][1]
#         return "[#{nums[i]},#{nums[i+1]}]"
#     elsif nums[i][1] < nums[i+1][1] && nums[i][1] == depth
#         return "[#{nums[i]},#{reconstruct_string(nums, i + 1, depth + 1)}]"
#     elsif nums[i][1] < nums[i+1][1] && nums[i][1] == depth
#         return "[#{nums[i]},#{reconstruct_string(nums, i + 1, depth + 1)}]"
#     else
#         return "[#{reconstruct_string(nums, i + 1, depth + 1)}},#{reconstruct_string(nums, i + 1, depth + 1)}]"
#     end
# end

# def reconstruct_string(nums)
#     depth = 0
#     res = ""
#     nums.each_with_index do |(n, d), i|
#         while d > depth
#             res += ?[
#             depth += 1
#         end
#         while d < depth
#             res += ?]
#             depth -= 1
#         end
#         if i < nums.length - 1 && d <= nums[i + 1][1]
#             res += "#{n},"
#         elsif i < nums.length - 1 && d > nums[i + 1][1]
#             res += "#{n}" 
#             while depth != nums[i + 1][1]
#                 res += ?]
#                 depth -= 1
#             end
#             res += ?,
#         elsif i == nums.length - 1
#             res += "#{n}" 
#             while depth != 0
#                 res += ?]
#                 depth -= 1
#             end
#         end
#     end
#     res
# end

def day18_1
    problems = []
    line_index = -1
    prob = $lines[0]
    while line_index < $lines.length - 1
        line_index += 1
        depth = 0
        nums = []
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
        changed = true
        last_length = nums.length
        while changed
            reduce(nums)
            changed = last_length != nums.length
            last_length = nums.length
        end

        # pp reconstruct_string(nums)
        # prob = "[#{reconstruct_string(nums)},#{$lines[line_index + 1]}]"
        # line_index += 1
        pp nums
    end

end




# def reduce(prob, depth)
#     l, r = prob
#     if prob.to_s && match(/\[\d+, \d+\]/) && depth == 4
#         return prob
#     if depth == 3
#         if l.is_a?(Array)
#             to_add = l[0]
#             new_pair = [0, l[1] + r]
#             return [:left, to_add, new_pair]
#         elsif r.is_a(Array)


#         end
#     else
#         if reduce(l, depth + 1)

#         end
#     end


        
#         l_res = reduce(l, depth + 1)
#     if l.to_s.match(/\[\d+, \d+\]/) && depth == 3
#         return [:left, ]


#     if l.match(/\[\d+, \d+\]/) && r.match(/\d+/)

#     elsif (l.match(/\d+/) && r.match(/\[\d+, \d+\]/))
#         return [r, 0]
#     elsif depth == 3
#         if l.match(/\[\d+, \d+\]/) && r.match(/\d+/)

#         elsif (l.match(/\d+/) && r.match(/\[\d+, \d+\]/))
#             return [r, 0]

# def day18_1
#     problems = []
#     $lines.each do |l|
#         problems << eval(l)
#     end
#     problems

#     reduce(problems[0], 1)
# end

def day18_2
end

pp day18_1
pp day18_2