require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day18_1
  ground = Hash.new(?.)
  vertices = []

  dirs = {
    ?L => [0, -1],
    ?R => [0, 1],
    ?U => [-1, 0],
    ?D => [1, 0],
  }.freeze

  r, c = 0, 0
  vertices << [r, c]
  ground[[r, c]] = ?#

  $lines.each do |l|
    dir, n, _ = l.split
    n = n.to_i
    dr, dc = dirs[dir]

    n.times do
      r += dr
      c += dc
      ground[[r, c]] = ?#
    end
    vertices << [r, c]
  end

  # Print for debugging
  puts "Vertices: #{vertices}"

  xs = vertices.map(&:first)
  ys = vertices.map(&:last)

  # Shoelace Formula
  area = 0.5 * (0...vertices.length).reduce(0) do |sum, i|
    sum + (xs[i] * ys[(i + 1) % vertices.length] - xs[(i + 1) % vertices.length] * ys[i])
  end.abs

  area
end

def day18_2
end

pp day18_1
pp day18_2
