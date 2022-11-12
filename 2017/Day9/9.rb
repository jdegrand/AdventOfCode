file = 'input.txt'
input = File.read(file)

$line = input.lines.map(&:chomp)[0]

def day9_1
    l = $line.gsub("!!", "").gsub(/!./, "").gsub(/<[^>]*>/, "").gsub(",", "")
    score = 0
    open_braces = 0
    l.chars.each do |c|
        if c == "{"
            open_braces += 1
        else
            score += open_braces
            open_braces -= 1
        end
    end
    score
end

def day9_2
    garbage = $line.gsub("!!", "").gsub(/!./, "").scan(/<[^>]*>/)
    garbage.map(&:length).inject(:+) - (garbage.length * 2)
end

pp day9_1
pp day9_2
