file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)


def get_combo(op, reg)
  return op if (0..3).cover?(op)
  return reg[?A] if op == 4
  return reg[?B] if op == 5
  return reg[?C] if op == 6
  raise "Combo operand 7 occured which should not be valid..."
end

def day17_1
  reg = {
    ?A => $lines[0].split.last.to_i,
    ?B => $lines[1].split.last.to_i,
    ?C => $lines[2].split.last.to_i,
  }

  program = $lines[4].split.last.split(?,).map(&:to_i)
  cursor = 0
  out = []
  while true
    break if cursor >= program.length
    opcode = program[cursor]
    operand = program[cursor + 1]
    jumped = false
    case opcode
    when 0
      reg[?A] = reg[?A] / (2 ** get_combo(operand, reg))
    when 1
      reg[?B] = reg[?B] ^ operand
    when 2
      reg[?B] = get_combo(operand, reg) % 8
    when 3
      if reg[?A] != 0
        cursor = operand
        jumped = true
      end
    when 4
      reg[?B] = reg[?B] ^ reg[?C]
    when 5
      out.append(get_combo(operand, reg) % 8)
    when 6
      reg[?B] = reg[?A] / (2 ** get_combo(operand, reg))
    when 7
      reg[?C] = reg[?A] / (2 ** get_combo(operand, reg))
    end
    cursor += 2 unless jumped
  end
  out.map(&:to_s).join(?,)
end

def day17_2
  program = $lines[4].split.last.split(?,).map(&:to_i)

  (0..Float::INFINITY).each do |n|
    reg = {
      ?A => n,
      ?B => 0,
      ?C => 0,
    }

    cursor = 0
    out = []
    while true
      break if cursor >= program.length
      opcode = program[cursor]
      operand = program[cursor + 1]
      jumped = false
      case opcode
      when 0
        reg[?A] = reg[?A] / (2 ** get_combo(operand, reg))
      when 1
        reg[?B] = reg[?B] ^ operand
      when 2
        reg[?B] = get_combo(operand, reg) % 8
      when 3
        if reg[?A] != 0
          cursor = operand
          jumped = true
        end
      when 4
        reg[?B] = reg[?B] ^ reg[?C]
      when 5
        out.append(get_combo(operand, reg) % 8)
      when 6
        reg[?B] = reg[?A] / (2 ** get_combo(operand, reg))
      when 7
        reg[?C] = reg[?A] / (2 ** get_combo(operand, reg))
      end
      cursor += 2 unless jumped
    end
    return n if out == program
  end
end

puts day17_1
pp day17_2
