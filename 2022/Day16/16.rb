require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day16_1
    unvisited = Set.new
    neighbors = {}
    distance_from_start = {}
    rates = {}
    previous = {}

    reg = /Valve ([a-zA-Z]+).+rate=(\d+).+valves? (.+)/
    $lines.each do |l|
        valve, rate, valve_neighbors = l.match(reg).captures
        unvisited << valve
        neighbors[valve] = Set.new(valve_neighbors.split(", "))
        distance_from_start[valve] = -Float::INFINITY
        rates[valve] = rate.to_i
    end
    distance_from_start["AA"] = 0
    # previous["AA"] == nil

    visited = Set.new
    minutes = 0
    while curr = unvisited.max{|valve| distance_from_start[valve]}
        unvisited_neighbors = neighbors[curr] & unvisited
        pp unvisited_neighbors
        unvisited_neighbors.each do |neigh|
            new_distance = distance_from_start[curr] + rates[neigh]
            pp new_distance
            if new_distance > distance_from_start[neigh]
                distance_from_start[neigh] = new_distance
                previous[neigh] = curr
            end
        end
        visited << curr
        unvisited.delete(curr)
        minutes += 2
    end
    distance_from_start
    # neighbors[curr].filter
end

def day16_2
end

pp day16_1
pp day16_2
