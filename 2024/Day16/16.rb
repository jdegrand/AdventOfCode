require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day16_1
  grid = Hash.new(?#)
  start_node = [-1, -1]
  end_node = [-1, -1]
  unvisited = Set.new
  $lines.each_with_index{ |l, i|
    l.chars.each_with_index{ |ch, j|
      grid[[i, j]] = ch
      start_node = [i, j] if ch == ?S
      end_node = [i, j] if ch == ?E
      if ch == ?. || ch == ?S || ch == ?E
        [[0, 1], [1, 0], [0, -1], [-1, 0]].each{ |dir|
          unvisited << [[i, j], dir]
        }
      end
    }
  }

  distances = Hash.new(Float::INFINITY)
  distances[[start_node, [0, 1]]] = 0

  until unvisited.empty?
    curr, dir = unvisited.min_by{ distances[_1] }
    break if distances[[curr, dir]] == Float::INFINITY
    [[0, 1], [1, 0], [0, -1], [-1, 0]].each{ |next_dir|
      next_point = curr.zip(next_dir).map(&:sum)
      next if grid[next_point] == ?#
      if next_dir == dir
        distances[[next_point, next_dir]] = [distances[[next_point, next_dir]], distances[[curr, dir]] + 1].min
      elsif next_dir.map(&:abs) == dir.map(&:abs)
        # Do nothing, let's not go backwards
      else
        distances[[curr, next_dir]] = [distances[[curr, next_dir]], distances[[curr, dir]] + 1000].min
      end
    }

    unvisited.delete([curr, dir])
  end
  
  distances.filter{ |(pt, _), _| pt == end_node}.values.min
end

def day16_2
  grid = Hash.new(?#)
  start_node = [-1, -1]
  end_node = [-1, -1]
  unvisited = Set.new
  $lines.each_with_index{ |l, i|
    l.chars.each_with_index{ |ch, j|
      grid[[i, j]] = ch
      start_node = [i, j] if ch == ?S
      end_node = [i, j] if ch == ?E
      if ch == ?. || ch == ?S || ch == ?E
        [[0, 1], [1, 0], [0, -1], [-1, 0]].each{ |dir|
          unvisited << [[i, j], dir]
        }
      end
    }
  }

  distances = Hash.new([Float::INFINITY, []])
  distances[[start_node, [0, 1]]] = [0, []]

  until unvisited.empty?
    curr, dir = unvisited.min_by{ distances[_1].first }
    break if distances[[curr, dir]].first == Float::INFINITY
    [[0, 1], [1, 0], [0, -1], [-1, 0]].each{ |next_dir|
    next_point = curr.zip(next_dir).map(&:sum)
      next if grid[next_point] == ?#
      if next_dir == dir
        if distances[[next_point, next_dir]].first == distances[[curr, dir]].first + 1
          distances[[next_point, next_dir]] = [distances[[next_point, next_dir]].first, distances[[next_point, next_dir]].last + [[curr, dir]]]
        else
          distances[[next_point, next_dir]] = [[distances[[next_point, next_dir]].first, distances[[next_point, next_dir]].last], [distances[[curr, dir]].first + 1, [[curr, dir]]]].min_by{ _1.first }
        end
      elsif next_dir.map(&:abs) == dir.map(&:abs)
        # Do nothing, let's not go backwards
      else
        if distances[[curr, next_dir]].first == distances[[curr, dir]].first + 1000
          distances[[curr, next_dir]] = [distances[[curr, next_dir]].first, distances[[curr, next_dir]].last + [[curr, dir]]]
        else
          distances[[curr, next_dir]] = [[distances[[curr, next_dir]].first, distances[[curr, next_dir]].last], [distances[[curr, dir]].first + 1000, [[curr, dir]]]].min_by{ _1.first }
        end
      end
    }

    unvisited.delete([curr, dir])
  end
  
  queue = []
  distances.filter{ |(pt, _), _| pt == end_node}.values.min_by{ _1.first }.last.each{ queue << _1 }
  best_path = Set.new(queue)
  until queue.empty?
    path_val = queue.shift
    distances[path_val].last.each{
      if !best_path.include?(_1)
        best_path << _1
        queue.append(_1)
      end
    }
  end

  # Add one to include end node
  Set.new(best_path.map(&:first)).size + 1
end

pp day16_1
pp day16_2
