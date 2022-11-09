file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day4_1
    ($lines.filter do |l|
        phrases = l.split
        phrases.length == phrases.uniq.length
    end).length
end

def day4_2
    ($lines.filter do |l|
        phrases = l.split.map{|p| p.chars.tally}
        phrases.length == phrases.uniq.length
    end).length
end

pp day4_1
pp day4_2
