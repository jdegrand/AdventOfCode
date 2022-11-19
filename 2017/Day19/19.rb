file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day19
    entry = $lines[0].index(?|)
    letters = ''
    index = [0, entry]
    dir = [1, 0]
    steps = 0
    while true
        steps += 1
        next_r, next_c = index[0] + dir[0], index[1] + dir[1]
        next_char = $lines[next_r][next_c]
        case next_char
        when ?|
            index = [next_r, next_c]
        when ?-
            index = [next_r, next_c]
        when ?+
            next_index = ([[next_r - 1, next_c], [next_r + 1, next_c], [next_r, next_c - 1], [next_r, next_c + 1]] - [index]).select{|r, c| $lines[r][c] != ' '}[0]
            dir = [next_index[0] - next_r, next_index[1] - next_c]
            char = $lines[next_index[0]][next_index[1]]
            letters += char if /[A-Z]/.match(char)
            index = next_index
            steps += 1
        when /[A-Z]/
            letters += next_char
            index = [next_r, next_c]
        else
            break
        end
    end
    pp letters
    pp steps
end

day19
