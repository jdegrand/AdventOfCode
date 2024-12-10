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
  nums = []
  spaces = []
  index = 0
  curr_num = 0
  is_space = false
  $lines[0].chars.each{ |c|
    c = c.to_i
    if is_space
      spaces << (index...(index + c))
      (index...(index + c)).each{ |n| fs[n] = 0 }
    else
      nums << [curr_num, (index...(index + c))]
      (index...(index + c)).each{ |n| fs[n] = curr_num }
      curr_num += 1
    end
    index += c
    is_space = !is_space
  }

  until nums.length == 0
    num, range = nums.pop
    file_size = range.size

    spaces.each_with_index{ |space, ind|
      # Only move files to their left 
      break if space.last > range.first

      if space.size >= file_size
        # Remove from old spot in file system
        range.each{ fs[_1] = 0 }

        # Add to new spot in file syste
        (space.first...(space.first + file_size)).each{ fs[_1] = num }

        diff = space.size - file_size
        if diff > 0
          spaces[ind] = ((space.first + file_size)...space.last)
        else
          spaces.delete_at(ind)
        end
        break
      end
    }
  end

  (0...fs.length).reduce(0) {|v, i| v + fs[i] * i}

end

pp day9_1
pp day9_2
