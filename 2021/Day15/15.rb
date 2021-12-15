# https://github.com/rubyworks/pqueue

require 'pqueue'
require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day15_1
    distances = Hash.new(Float::INFINITY)
    values = Hash.new(Float::INFINITY)
    $lines.each_with_index do |l, r|
        l.chars.each_with_index do |k, c|
            values[[r,c]] = k.to_i
        end
    end

    distances[[0,0]] = 0
    visited = Set.new
    unvisited = distances.keys

    end_c = [$lines.length - 1, $lines[0].length - 1]

    adj = [[0, -1], [0, 1], [-1, 0], [1, 0]]

    until distances[end_c] < Float::INFINITY
        unvisited = distances.keys.sort_by{|c| distances[c]}.reject{|c| visited.include?(c)}
        curr = unvisited.shift
        adj.each do |dx, dy|
            neigh = [curr[0] + dx, curr[1] + dy]
            distances[neigh] = distances[curr] + values[neigh] if (!visited.include?(neigh)) && (distances[curr] + values[neigh] < distances[neigh])
        end
        visited << curr
    end

    distances[end_c]
end

class Node
    def initialize(name, value)
        @name = name
        @value = value
    end

    def fetch
        [@name, @value]
    end

    def <=>(comp)
        -1 * (self.value <=> comp.value)
    end

    attr_accessor :name
    attr_accessor :value
end

def day15_2
    distances = Hash.new(Float::INFINITY)
    values = Hash.new(Float::INFINITY)
    5.times do |rt|
        $lines.each_with_index do |l, r|
            5.times do |ct|
                l.chars.each_with_index do |k, c|   
                    values[[r + (rt * $lines.length), c + (ct * l.length)]] = k.to_i + ct + rt > 9 ? k.to_i + ct + rt - 9 : k.to_i + ct + rt
                end
            end
        end
    end

    distances[[0,0]] = 0
    visited = Set.new
    
    unvisited = PQueue.new([Node.new([0, 0], 0)])

    end_c = [$lines.length * 5 - 1, $lines[0].length * 5 - 1]

    adj = [[0, -1], [0, 1], [-1, 0], [1, 0]]

    until distances[end_c] < Float::INFINITY
        curr, val = unvisited.pop.fetch
        adj.each do |dx, dy|
            neigh = [curr[0] + dx, curr[1] + dy]
            if (!visited.include?(neigh)) && (val + values[neigh] < distances[neigh])
                distances[neigh] = val + values[neigh]
                unvisited.push(Node.new(neigh, val + values[neigh]))
            end
        end
        visited << curr
    end

    distances[end_c]
end

pp day15_1
pp day15_2
