file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day2_1
    maxes = {
        "red" => 12,
        "green" => 13,
        "blue" => 14
    }.freeze

    $lines.map.with_index do |l, i|
        sets = l.gsub(/Game \d+: /, "").split("; ")
        cubes = Hash.new(0)
        sets.each do |s|
            s.split(", ").each do |cube|
                num, color = cube.split
                cubes[color] = [cubes[color], num.to_i].max
            end
        end
        [cubes["red"] <= maxes["red"] && cubes["green"] <= maxes["green"] && cubes["blue"] <= maxes["blue"], i + 1]
    end.filter{|possible, _| possible}.map{|_, i| i}.sum
end

def day2_2
    $lines.map.with_index do |l, i|
        sets = l.gsub(/Game \d+: /, "").split("; ")
        cubes = Hash.new(0)
        sets.each do |s|
            s.split(", ").each do |cube|
                num, color = cube.split
                cubes[color] = [cubes[color], num.to_i].max
            end
        end
        cubes["red"] * cubes["green"] * cubes["blue"]
    end.sum
end

pp day2_1
pp day2_2
