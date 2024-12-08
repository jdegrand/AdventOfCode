require "set"

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day8_1
  grid = Hash.new(?*)
  frequencies = Hash.new([])

  $lines.each_with_index { |l, i|
    l.chars.each_with_index{ |c, j|
      grid[[i, j]] = c
      frequencies[c] += [[i, j]] if c != ?.
    }
  }

  antinodes = Set.new
  frequencies.values.each{ |freq|
    freq.combination(2).each{ |c1, c2|
      x1, y1 = c1
      x2, y2 = c2
      dx = x1 - x2
      dy = y1 - y2
      local_freq = Set.new
      [c1, c2].each { |x, y|
        local_freq << [x - dx, y - dy]
        local_freq << [x + dx, y + dy]
      }
      local_freq.delete(c1).delete(c2).reject!{ |c| grid[c] == ?* }
      antinodes.merge(local_freq)
    }
  }
  antinodes.length
end

def day8_2
  grid = Hash.new(?*)
  frequencies = Hash.new([])

  $lines.each_with_index { |l, i|
    l.chars.each_with_index{ |c, j|
      grid[[i, j]] = c
      frequencies[c] += [[i, j]] if c != ?.
    }
  }

  antinodes = Set.new
  frequencies.values.each{ |freq|
    freq.combination(2).each{ |c1, c2|
      x1, y1 = c1
      x2, y2 = c2
      dx = x1 - x2
      dy = y1 - y2
      local_freq = Set.new
      [c1, c2].each { |x, y|
        curr = [x - dx, y - dy]
        until grid[curr] == ?*
          local_freq << curr
          curr = [curr.first - dx, curr.last - dy]
        end
        curr = [x + dx, y + dy]
        until grid[curr] == ?*
          local_freq << curr
          curr = [curr.first + dx, curr.last + dy]
        end
      }
      antinodes.merge(local_freq)
    }
  }
  antinodes.length
end

pp day8_1
pp day8_2
