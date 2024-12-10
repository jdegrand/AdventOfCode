require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def recurse_part1(current_val, target_value, was_reached, current_index, operands)
  if current_index == operands.length && current_val == target_value
    was_reached[0] = true
  elsif current_index < operands.length && current_val <= target_value && was_reached.first == false
    recurse_part1(current_val * operands[current_index], target_value, was_reached, current_index + 1, operands)
    recurse_part1(current_val + operands[current_index], target_value, was_reached, current_index + 1, operands)
  end
end 

def day7_1
  $lines.reduce(0) { |v, l|
    test_val, operands = l.split(": ")
    test_val = test_val.to_i
    operands = operands.split.map(&:to_i)

    was_reached = [false]
    recurse_part1(operands.first, test_val, was_reached, 1, operands)

    was_reached.first ? v + test_val : v
  }
end

def recurse_part2(current_val, target_value, was_reached, current_index, operands)
  if current_index == operands.length && current_val == target_value
    was_reached[0] = true
  elsif current_index < operands.length && current_val <= target_value && was_reached.first == false
    recurse_part2(current_val * operands[current_index], target_value, was_reached, current_index + 1, operands)
    recurse_part2(current_val + operands[current_index], target_value, was_reached, current_index + 1, operands)
    recurse_part2("#{current_val}#{operands[current_index]}".to_i, target_value, was_reached, current_index + 1, operands)
  end
end 

def day7_2
  $lines.reduce(0) { |v, l|
    test_val, operands = l.split(": ")
    test_val = test_val.to_i
    operands = operands.split.map(&:to_i)

    was_reached = [false]
    recurse_part2(operands.first, test_val, was_reached, 1, operands)

    was_reached.first ? v + test_val : v
  }
end

pp day7_1
pp day7_2
