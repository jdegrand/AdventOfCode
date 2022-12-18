file = 'input.txt'
input = File.read(file)

$jets = input.lines.map(&:chomp)[0]
$rocks = [
    ['####'],
    ['.#.', '###', '.#.'],
    ['..#', '..#', '###'],
    ['#', '#', '#', '#'],
    ['##', '##']
]
def day17_1
    chamber = Hash.new(?.)
    (0...7).each{|n| chamber[[0, n]] = ?#}
    highest = 1

    jets_index = 0
    2022.times do |t|
        rock = $rocks[t % 5]
        rock_start = 2
        rock_end = 2 + rock[0].length - 1
        rock_vert = highest + 3
        while true
            case $jets[jets_index]
            when ?<
                rock.reverse.each_with_index.map{|r, i|}
                if rock_start > 0 && rock.reverse.each_with_index.all?{|r, i| r.chars.each_with_index.none?{|c, ci| chamber[[rock_vert + i, rock_start - 1 + ci]] == ?# && c == ?#}}
                    rock_start -= 1
                    rock_end -= 1
                end
            when ?>
                if rock_end + 1 < 7 && rock.reverse.each_with_index.all?{|r, i| r.chars.each_with_index.none?{|c, ci| chamber[[rock_vert + i, rock_start + 1 + ci]] == ?# && c == ?#}}
                    rock_start += 1
                    rock_end += 1
                end
            else
                raise "Invalid jet input!"
            end
            jets_index = (jets_index + 1) % $jets.length
            next_vert = rock_vert - 1
            break if (rock_start..rock_end).map{|n| chamber[[next_vert, n]]}.each_with_index.any?{|r, i| rock[-1][i] == ?# && r == ?#}
            rock_vert -= 1
        end
        rock.each_with_index{|layer, li| layer.chars.each_with_index{|c, ci| chamber[[rock_vert + (rock.length - 1 - li), rock_start + ci]] = c if c == ?#}}
        highest = rock_vert + rock.length
    end
    print(chamber)
    highest - 1
end

def print(chamber)
    30.downto(0).each do |r|
        ch = "|" 
        (0...7).each{|c| ch += chamber[[r,c]]}
        ch += "|"
        puts ch
    end
    puts
end

def day17_2
end

pp day17_1
pp day17_2
