file = 'input.txt'
input = File.read(file)

$lines = input.lines

def dance(programs, dance_moves)
    spin = /s(\d+)/
    exchange = /x(\d+)\/(\d+)/
    partner = /p([a-p])\/([a-p])/
    
    dance_moves.each do |m|
        case m
        when spin
            programs.rotate!(-1 * spin.match(m).captures[0].to_i)
        when exchange
            a, b = exchange.match(m).captures
            a, b = [a, b].map(&:to_i)
            old_a = programs[a]
            programs[a] = programs[b]
            programs[b] = old_a
        when partner
            capture = partner.match(m).captures
            a, b = programs.each_with_index.select{|p, i| capture.include?(p)}
            programs[a[1]] = b[0]
            programs[b[1]] = a[0]
        else
            raise "NOT MATCHED #{m}"
        end
    end
end

def day16_1
    programs = ('a'..'p').to_a
    dance_moves = $lines[0].split(?,)
    dance(programs, dance_moves)
    programs.join
end

def day16_2
    starting_programs = ('a'..'p').to_a
    programs = ('a'..'p').to_a
    dance_moves = $lines[0].split(?,)
    upper_limit = 1000000000
    loop_at = upper_limit.times do |t|
        dance(programs, dance_moves)
        break t if starting_programs == programs
    end
    ((upper_limit % loop_at) - 1).times{dance(programs, dance_moves)}
    programs.join
end

pp day16_1
pp day16_2
