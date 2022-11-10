require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day6_1
    states = Set.new
    current_state = $lines[0].split.map(&:to_i)
    steps = 0
    until states === current_state
        states << current_state
        max_index = current_state.index(current_state.max)
        distribute = current_state[max_index]
        current_state[max_index] = 0
        index_pointer = (max_index + 1) % current_state.length
        distribute.times do
            current_state[index_pointer] += 1
            index_pointer = (index_pointer + 1) % current_state.length
        end
        steps += 1
    end
    [current_state, steps]
end

def day6_2(start_state)
    states = Set.new
    current_state = start_state.clone
    steps = 0
    found_again = false
    until found_again
        states << current_state
        max_index = current_state.index(current_state.max)
        distribute = current_state[max_index]
        current_state[max_index] = 0
        index_pointer = (max_index + 1) % current_state.length
        distribute.times do
            current_state[index_pointer] += 1
            index_pointer = (index_pointer + 1) % current_state.length
        end
        steps += 1
        found_again = true if current_state == start_state
    end
    steps
end

start_part_2, part_1 = day6_1

pp part_1
pp day6_2(start_part_2)
