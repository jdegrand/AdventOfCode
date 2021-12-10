file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day10_1
    invalid = Hash.new(0)
    opens = [?(, ?[, ?{, ?<]
    closes = [?), ?], ?}, ?>]
    $lines.each do |l|
        stack = []
        l.chars.each do |c|
            if opens.include?(c)
                stack.unshift(c)
            else
                if stack.length == 0 then break end
                if opens.index(stack[0]) == closes.index(c)
                    stack.shift
                else
                    invalid[c] += 1
                    break
                end
            end
        end
    end
    invalid.map{|k, v|
        case k
        when ?)
            v * 3
        when ?]
            v * 57
        when ?}
            v * 1197
        when ?>
            v * 25137
        end
    }.sum
end

def day10_2
    invalid = Hash.new(0)
    opens = [?(, ?[, ?{, ?<]
    closes = [?), ?], ?}, ?>]
    incomplete = []
    $lines.each do |l|
        stack = []
        points = 0
        inc = true
        l.chars.each do |c|
            if opens.include?(c)
                stack.unshift(c)
            else
                if opens.index(stack[0]) == closes.index(c)
                    stack.shift
                else
                    inc = false
                    until stack.length == 0
                        curr = stack.shift
                        points = (points * 5) + (opens.index(curr) + 1)
                    end
                    break
                end
            end
        end
        if inc
            points = 0
            until stack.length == 0
                curr = stack.shift
                points = (points * 5) + (opens.index(curr) + 1)
            end
            incomplete << points
        end
    end
    incomplete.sort[incomplete.length / 2]
end

pp day10_1
pp day10_2
