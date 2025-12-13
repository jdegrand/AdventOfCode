require 'Set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day8_1
    circuits = Hash.new(Set.new)
    junction_to_circuit = {}
    junctions = $lines.map{ _1.split(?,).map(&:to_i) }
    shortest_distance = junctions.combination(2).sort_by{ Math.sqrt(_1.zip(_2)
        .map{ |q, p|
            (p - q) ** 2
        }.sum)
    }
    circuit_counter = 0
    1000.times{ |i|
        j1, j2 = shortest_distance[i]
        j1_circuit = junction_to_circuit[j1]
        j2_circuit = junction_to_circuit[j2]
        if j1_circuit && j2_circuit
            if j1_circuit != j2_circuit
                circuits[j1_circuit] += circuits[j2_circuit]
                circuits[j2_circuit].each{ junction_to_circuit[_1] = j1_circuit }
                circuits[j2_circuit] = Set.new
            end
        elsif j1_circuit
            junction_to_circuit[j2] = j1_circuit
            circuits[j1_circuit] << j2
        elsif j2_circuit
            junction_to_circuit[j1] = j2_circuit
            circuits[j2_circuit] << j1
        else
            circuits[circuit_counter] = Set.new([j1, j2])
            junction_to_circuit[j1] = circuit_counter
            junction_to_circuit[j2] = circuit_counter
            circuit_counter += 1
        end
    }
    circuits.values.map(&:size).max(3).inject(:*)
end

def day8_2
    circuits = Hash.new(Set.new)
    junction_to_circuit = {}
    junctions = $lines.map{ _1.split(?,).map(&:to_i) }
    unattached_junctions = Set.new(junctions)
    shortest_distance = junctions.combination(2).sort_by{ Math.sqrt(_1.zip(_2)
        .map{ |q, p|
            (p - q) ** 2
        }.sum)
    }
    circuit_counter = 0
    index = 0
    j1, j2 = nil, nil
    until unattached_junctions.empty?
        j1, j2 = shortest_distance[index]
        j1_circuit = junction_to_circuit[j1]
        j2_circuit = junction_to_circuit[j2]
        if j1_circuit && j2_circuit
            if j1_circuit != j2_circuit
                circuits[j1_circuit] += circuits[j2_circuit]
                circuits[j2_circuit].each{ junction_to_circuit[_1] = j1_circuit }
                circuits[j2_circuit] = Set.new
            end
        elsif j1_circuit
            junction_to_circuit[j2] = j1_circuit
            circuits[j1_circuit] << j2
            unattached_junctions.delete(j2)
        elsif j2_circuit
            junction_to_circuit[j1] = j2_circuit
            circuits[j2_circuit] << j1
            unattached_junctions.delete(j1)
        else
            circuits[circuit_counter] = Set.new([j1, j2])
            junction_to_circuit[j1] = circuit_counter
            junction_to_circuit[j2] = circuit_counter
            unattached_junctions.delete(j1)
            unattached_junctions.delete(j2)
            circuit_counter += 1
        end
        index += 1
    end
    j1.first * j2.first
end

pp day8_1
pp day8_2
