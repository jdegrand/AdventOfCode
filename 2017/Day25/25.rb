file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n")

def day25_1
    run_info, *states_list = $lines
    run_info = run_info.lines.map(&:chomp)
    current_state = run_info[0].split[-1].chop
    diagnostic_steps = run_info[1].split[-2].to_i

    states = {}
    states_list.map{|state| state.lines.map{|l| l.chomp.split[-1].chop}}.each{|state, *state_info| states[state] = state_info}
    
    tape = Hash.new(?0)
    cursor = 0

#     If the current value is 0:
#     - Write the value 1.
#     - Move one slot to the right.
#     - Continue with state B.
#   If the current value is 1:
#     - Write the value 0.
#     - Move one slot to the left.
#     - Continue with state E.
    diagnostic_steps.times do
        state_intr = states[current_state]
        if tape[cursor] == ?0
            tape[cursor] = state_intr[1]
            cursor += state_intr[2] == "right" ? 1 : -1
            current_state = state_intr[3]
        elsif tape[cursor] == ?1
            tape[cursor] = state_intr[5]
            cursor += state_intr[6] == "right" ? 1 : -1
            current_state = state_intr[7]
        else
            raise "Current value on tape is not 0 or 1!"
        end
    end
    tape.count{|_, v| v == ?1}
end

def day25_2
    "50 stars deposited to reboot the printer ! <3"
end

pp day25_1
puts day25_2
