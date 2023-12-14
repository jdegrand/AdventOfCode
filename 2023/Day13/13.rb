file = 'input.txt'
input = File.read(file)

$sections = input.split("\n\n")

def day13_1
    $sections.map{ |section|
        horizontal = [section.lines.map{ _1.chomp.chars }.freeze, :horizontal]
        vertical = [horizontal.first.transpose.freeze, :vertical]
        [horizontal, vertical].each { |section, direction|
            found = nil
            (1...section.length).each { |index|
                top = section[0...index]
                bottom = section[index...([index + index, section.length].min)]
                top.shift until top.length == bottom.length
                if top.reverse == bottom
                    found = [index, direction]
                    break
                end
            }
            break found.first * (found.last == :horizontal ? 100 : 1) if found
        }
    }.sum
end

def day13_2
    $sections.map{ |section|
        horizontal = [section.lines.map{ _1.chomp.chars }.freeze, :horizontal]
        vertical = [horizontal.first.transpose.freeze, :vertical]
        [horizontal, vertical].each { |section, direction|
            found = nil
            (1...section.length).each { |index|
                top = section[0...index]
                bottom = section[index...([index + index, section.length].min)]
                top.shift until top.length == bottom.length
                if top.reverse.flatten.zip(bottom.flatten).count{ _1 != _2 } == 1
                    found = [index, direction]
                    break
                end
            }
            break found.first * (found.last == :horizontal ? 100 : 1) if found
        }
    }.sum
end

pp day13_1
pp day13_2
