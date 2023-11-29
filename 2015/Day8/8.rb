file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day8_1
    hexidecimal = /\\x[0-9A-Fa-f]{2}/
    $lines.map do |l|
        new_line = l.gsub("\\\\", " ").gsub("\\\"", " ").gsub(hexidecimal, " ")
        [l.length, new_line.length - 2]
    end.transpose.map(&:sum).inject(:-)
end

def day8_2
    hexidecimal = /\\x[0-9A-Fa-f]{2}/
    $lines.map{|l| [l.inspect.length, l.length]}.transpose.map(&:sum).inject(:-)
end

pp day8_1
pp day8_2
