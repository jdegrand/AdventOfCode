require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def backtrack(curr, curr_rate, pressure, neighbors, rates, opened, states, max, count)
    return if states.include?([curr, curr_rate, pressure, count, opened.sort.to_a])
    states << [curr, curr_rate, pressure, count, opened.sort.to_a]
    if count <= 0
        max[0] = [curr_rate, max[0]].max
        # pp max
        return
    end
    if opened.include?(curr)
        neighbors[curr].each{|neigh| backtrack(neigh, curr_rate + (pressure * 1), pressure, neighbors, rates, opened, states, max, count - 1)}
    else
        opened << curr
        neighbors[curr].each{|neigh| backtrack(neigh, curr_rate + (pressure * 2), pressure + rates[curr], neighbors, rates, opened, states, max, count - 2)} if count - 2 >= 0
        opened.delete(curr)

        neighbors[curr].each{|neigh| backtrack(neigh, curr_rate + (pressure * 1), pressure, neighbors, rates, opened, states, max, count - 1)}
    end
end

def backtrack2(curr, neighbors, rates, opened, states, count, moves, all_moves)
    if count <= 0
        all_moves << moves
        # moves.each_with_index.map{|m, i| m * (30 - i + 1)}
        # pp all_moves.length if all_moves.length % 100000 == 0
        # pp all_moves.length
        return
    end
    # return if states.include?([curr, count,  moves])
    # states << [curr, count, moves]

    if !opened.include?(curr) && rates[curr] != 0
        opened << curr
        # moves.push(0, rates[curr])
        neighbors[curr].each{|neigh| backtrack2(neigh, neighbors, rates, opened, states, count - 2, moves, all_moves)} if count - 2 >= 0
        opened.delete(curr)
        # moves.pop(2)
    end
    # moves.push(0)
    neighbors[curr].each{|neigh| backtrack2(neigh, neighbors, rates, opened, states, count - 1, moves, all_moves)}
    # moves.pop
end

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
    opened = Set.new
    max = [0]
    states = Set.new
    all_moves = Set.new
    moves = []
    # backtrack("AA", 0, 0, neighbors, rates, opened, states, max, 30)
    backtrack2("AA", neighbors, rates, opened, states, 30, moves, all_moves)
    max[0]
end

def day16_2
end

pp day16_1
pp day16_2
