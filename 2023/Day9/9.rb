file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day9_1
    $lines.map { |l|
        all_nums = {}
        index = 0
        nums = l.split.map(&:to_i)
        all_nums[index] = nums
        until nums.all?{ _1 == 0 }
            index += 1
            nums = nums.each_cons(2).map{_2 - _1}
            all_nums[index] = nums
        end
        all_nums[index] << 0
        until index == 0
            all_nums[index - 1] << all_nums[index - 1].last + all_nums[index].last
            index -= 1
        end
        all_nums[0].last
    }.sum
end

def day9_2
    $lines.map { |l|
        all_nums = {}
        index = 0
        nums = l.split.map(&:to_i)
        all_nums[index] = nums
        until nums.all?{ _1 == 0 }
            index += 1
            nums = nums.each_cons(2).map{_2 - _1}
            all_nums[index] = nums
        end
        all_nums[index].unshift(0)
        until index == 0
            all_nums[index - 1].unshift(all_nums[index - 1].first - all_nums[index].first)
            index -= 1
        end
        all_nums[0].first
    }.sum
end

pp day9_1
pp day9_2
