require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day10_1
  grid = Hash.new(-1)
  trailheads = []

  $lines.each_with_index{ |l, i|
    l.chars.each_with_index{ |c, j|
      trailheads << [i, j] if c == ?0
      grid[[i, j]] = c.to_i
    }
  }

  trailheads.reduce(0) { |v, th|
    reachable = Set.new
    queue = [th]

    until queue.empty?
      curr = queue.shift
      if grid[curr] == 9
        reachable << curr
      end
      [[-1, 0], [1, 0], [0, -1], [0, 1]].map{ |dx, dy|
        [curr.first + dx, curr.last + dy]
      }.filter{
        grid[_1] == grid[curr] + 1
      }.each{ queue << _1}
    end
    v + reachable.size
  }
end

def day10_2
  grid = Hash.new(-1)
  trailheads = []

  $lines.each_with_index{ |l, i|
    l.chars.each_with_index{ |c, j|
      trailheads << [i, j] if c == ?0
      grid[[i, j]] = c.to_i
    }
  }

  trailheads.reduce(0) { |v, th|
    count = 0
    queue = [th]

    until queue.empty?
      curr = queue.shift
      if grid[curr] == 9
        count += 1
      end
      [[-1, 0], [1, 0], [0, -1], [0, 1]].map{ |dx, dy|
        [curr.first + dx, curr.last + dy]
      }.filter{
        grid[_1] == grid[curr] + 1
      }.each{ queue << _1}
    end
    v + count
  }
end

pp day10_1
pp day10_2
