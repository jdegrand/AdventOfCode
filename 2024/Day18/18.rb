require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day18_1
  grid = {}
  lb = 0
  ub = 70
  bytes = 1024
  $lines[0...bytes].each { |l|
    x, y = l.split(?,).map(&:to_i)
    grid[[x, y]] = ?#
  }

  queue = [[0, 0]]
  visited = Set.new(queue)
  prev = {}

  until queue.empty?
    curr = queue.shift
    break if curr == [ub, ub]
    [[0, -1], [0, 1], [-1, 0], [1, 0]].map{ |diff| curr.zip(diff).map(&:sum)}.each{ |next_coord|
      if !visited.include?(next_coord) && next_coord.all?{ _1 >= lb } && next_coord.all?{ _1 <= ub } && grid[next_coord] != ?#
        queue << next_coord 
        visited << next_coord
        prev[next_coord] = curr
      end
    }
  end

  path = Set.new
  curr = [ub, ub]
  count = 0
  until curr == [lb, lb]
    count += 1
    path << curr
    curr = prev[curr]
  end

  count
end

def day18_2
  grid = {}
  lb = 0
  ub = 70
  bytes = 1024
  $lines[0...bytes].each { |l|
    x, y = l.split(?,).map(&:to_i)
    grid[[x, y]] = ?#
  }

  while true
    x, y = $lines[bytes].split(?,).map(&:to_i)
    grid[[x, y]] = ?#

    queue = [[0, 0]]
    visited = Set.new(queue)
    prev = {}

    until queue.empty?
      curr = queue.shift
      break if curr == [ub, ub]
      [[0, -1], [0, 1], [-1, 0], [1, 0]].map{ |diff| curr.zip(diff).map(&:sum)}.each{ |next_coord|
        if !visited.include?(next_coord) && next_coord.all?{ _1 >= lb } && next_coord.all?{ _1 <= ub } && grid[next_coord] != ?#
          queue << next_coord 
          visited << next_coord
          prev[next_coord] = curr
        end
      }
    end

    return $lines[bytes] if prev[[ub, ub]] == nil
    bytes += 1
  end
end

pp day18_1
puts day18_2
