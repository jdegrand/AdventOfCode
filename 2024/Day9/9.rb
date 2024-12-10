file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day9_1
  spaces = []
  nums = []
  index = 0
  curr_num = 0
  is_space = false
  $lines[0].chars.each{ |c|
    c = c.to_i
    if is_space
      (index...(index + c)).each{ |n| spaces << n }
    else
      c.times{ nums << curr_num }
      curr_num += 1
    end
    index += c
    is_space = !is_space
  }
  nums_index = 0
  final_index = 0
  final = []
  until nums.length <= nums_index
    if final_index < spaces.first
      final << nums[nums_index]
      nums_index += 1
    else
      final << nums.pop
      spaces.shift
    end
    final_index += 1

  end
  final.each_with_index.reduce(0) {|v, (n, i)| v + n * i}
end

def day9_2
  fs = {}
  chunks = Hash.new { |h, k| h[k] = [] }
  nums = []
  index = 0
  curr_num = 0
  is_space = false
  $lines[0].chars.each{ |c|
    c = c.to_i
    if is_space
      chunks[c] += [index]
      (index...(index + c)).each{ |n| fs[n] = 0 }
    else
      nums << [curr_num, (index...(index + c))]
      (index...(index + c)).each{ |n| fs[n] = curr_num }
      curr_num += 1
    end
    index += c
    is_space = !is_space
  }

  max = chunks.keys.max
  until nums.length == 0
    num, range = nums.pop
    file_size = range.size

    next if max < file_size

    # Remove chunk as its not available anymore
    ind = chunks[max].shift
    diff = max - file_size

    # Only move backwards, not forwards
    if ind < range.first

      # Add chunk difference to correct spot if it didn't fill entire spacee
      if diff > 0
        to_insert_at = chunks[diff].bsearch_index{_1 >= (ind + file_size)} || chunks[diff].length
        chunks[diff].insert(to_insert_at, ind + file_size)
      end

      # Remove from old spot in file system
      range.each{ fs[_1] = 0 }

      # Add to new spot in file system
      (ind...(ind + file_size)).each{ fs[_1] = num }
    end

    # Lower the max if no more spaces available
    until chunks[max].length != 0 || max == 0
      max -= 1
    end

  end
  # s = ""
  # (0...fs.length).each {|v| s += fs[v].to_s}
  # s

  # 11532524491670 too high

  (0...fs.length).reduce(0) {|v, i| v + fs[i] * i}

end

pp day9_1
pp day9_2
