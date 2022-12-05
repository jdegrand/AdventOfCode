file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n").map{|l| l.chomp}

def day5_1
    stacks = Hash.new([])
    start_state, moves = $lines
    start_state = start_state.lines.map(&:chomp)
    
    start_state[...-1].each do |l|
        l.chars.each_slice(4).with_index do |(_, c, _, _), i|
            stacks[i + 1] += [c] if c.match?(/[a-zA-Z]/)
        end
    end

    moves.lines.each do |m|
        how_many, from, to = m.scan(/\d+/).map(&:to_i)
        how_many.times do
            stacks[to].unshift(stacks[from].shift)
        end
    end

    ((1..stacks.length).map do |i|
        stacks[i][0]
    end).join
end

def day5_2
    stacks = Hash.new([])
    start_state, moves = $lines
    start_state = start_state.lines.map(&:chomp)
    
    start_state[...-1].each do |l|
        l.chars.each_slice(4).with_index do |(_, c, _, _), i|
            stacks[i + 1] += [c] if c.match?(/[a-zA-Z]/)
        end
    end

    moves.lines.each do |m|
        how_many, from, to = m.scan(/\d+/).map(&:to_i)
        stacks[to] = stacks[from].shift(how_many) + stacks[to]
    end

    ((1..stacks.length).map do |i|
        stacks[i][0]
    end).join
end

pp day5_1
pp day5_2
