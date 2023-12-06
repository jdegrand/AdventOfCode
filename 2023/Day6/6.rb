file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day6_1
    races = $lines[0].scan(/\d+/).map(&:to_i).zip($lines[1].scan(/\d+/).map(&:to_i))
    races.map do |time, distance|
        (0..time).map do |button_held|
            button_held * (time - button_held)
        end.filter{ _1 > distance }.length
    end.inject(:*)
end

def day6_2
    time = $lines[0].scan(/\d+/).join.to_i
    distance = $lines[1].scan(/\d+/).join.to_i
    (0..time).map do |button_held|
        button_held * (time - button_held)
    end.filter{ _1 > distance }.length
end

pp day6_1
pp day6_2
