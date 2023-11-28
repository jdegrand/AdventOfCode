file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day6_1
    reg = /(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)/
    lights = Hash.new(false)
    $lines.each do |l|
        action, *coords = l.match(reg).captures
        x0, y0, x1, y1 = coords.map(&:to_i)
        (x0..x1).each do |x|
            (y0..y1).each do |y|
                case action
                when "turn on"
                    lights[[x, y]] = true
                when "turn off"
                    lights[[x, y]] = false
                when "toggle"
                    lights[[x, y]] = !lights[[x, y]]
                end
            end
        end
    end
    lights.values.count(true)
end

def day6_2
    reg = /(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)/
    lights = Hash.new(0)
    $lines.each do |l|
        action, *coords = l.match(reg).captures
        x0, y0, x1, y1 = coords.map(&:to_i)
        (x0..x1).each do |x|
            (y0..y1).each do |y|
                case action
                when "turn on"
                    lights[[x, y]] += 1
                when "turn off"
                    lights[[x, y]] -= 1 if lights[[x, y]] != 0
                when "toggle"
                    lights[[x, y]] += 2
                end
            end
        end
    end
    lights.values.sum
end

pp day6_1
pp day6_2
