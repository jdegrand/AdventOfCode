# https://github.com/rubyworks/pqueue

require 'pqueue'
require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

class Node
    def initialize(value)
        @value = value
    end

    def <=>(comp)
        -1 * (self.value <=> comp.value)
    end

    attr_accessor :value
end

def print_path(board, previous, rows, cols)
    path = Hash.new(?.)
    curr = [rows - 1, cols - 1]
    path[curr] = ?#
    until curr == [0, 0]
        curr = previous[curr]
        path[curr] = ?#
    end

    (0...rows).each { |r|
        pp (0...cols).map { |c|
            path[[r, c]]
        }.join
    }

end

def day17_1
    heat_loss = {}
    total_heat = {}
    previous = {}
    $lines.each_with_index do |l, r|
        l.chars.each_with_index do |ch, c|
            heat_loss[[r, c]] = ch.to_i
            total_heat[[r, c]] = Float::INFINITY
            previous[[r, c]] = nil
        end
    end
    
    pq = PQueue.new
    visited = Set.new
    start = [0, 0]
    total_heat[start] = 0
    pq.push(Node.new([total_heat[start], start, [0, 0], 0]))

    until pq.empty?
        heat, curr, curr_dir, dir_count = pq.pop.value
        next if visited.include?([curr, curr_dir, dir_count])
        next if dir_count >= 3

        [[0, -1], [0, 1], [-1, 0], [1, 0]].filter{ heat_loss[[_1 + curr.first, _2 + curr.last]] && [-_1, -_2] != curr_dir }.each {
            next_dir = [_1, _2]
            next_pos = curr.zip(next_dir).map(&:sum)
            relative_heat = total_heat[curr] + heat_loss[curr]
            if relative_heat < total_heat[next_pos]
                total_heat[next_pos] = relative_heat
                previous[next_pos] = curr
                pq.push(Node.new([total_heat[next_pos], next_pos, next_dir, next_dir == curr_dir ? dir_count + 1 : 0]))
            end
        }

        visited << [curr, curr_dir, dir_count]
    end

    print_path(total_heat, previous, $lines.length, $lines[-1].length)

    total_heat[[$lines.length - 1, $lines[-1].length - 1]]
end

def day17_2
end

pp day17_1
pp day17_2
