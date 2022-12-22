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
    (0...7).each{|n| chamber[[-1, n]] = ?#}
    highest = -1
    rocks = $rocks.map(&:reverse)
    jets_index = 0
    15.times do |t|
        rock = rocks[t % 5]
        rock_start = 2
        rock_end = 2 + rock[0].length - 1
        bottom_rock = highest + 4
        while true
            case $jets[jets_index]
            when ?<
                if rock_start - 1 >= 0 && rock.each_with_index.map{|row, ri| row.chars.each_with_index.none?{|chr, ci| chamber[[bottom_rock + ri, rock_start - 1 + ci]] == ?# and chr == ?#}}.all?
                    rock_start -= 1
                    rock_end -= 1
                end
            when ?>
                if rock_end + 1 < 7 && rock.each_with_index.map{|row, ri| row.chars.each_with_index.none?{|chr, ci| chamber[[bottom_rock + ri, rock_start + 1 + ci]] == ?# and chr == ?#}}.all?
                    rock_start += 1
                    rock_end += 1
                end
            else
                raise "Invalid jet input!"
            end
            jets_index = (jets_index + 1) % $jets.length
            break if rock[0].chars.each_with_index.any?{|chr, ci| chamber[[bottom_rock - 1, rock_start + ci]] == ?# && chr == ?#}
            bottom_rock -= 1
        end
        rock.each_with_index{|row, ri| row.chars.each_with_index{|chr, ci| chamber[[bottom_rock + ri, rock_start + ci]] = chr if chr == ?#}}
        # print(chamber)
        highest = [bottom_rock + rock.length - 1, highest].max
        pp highest + 1
    end
    # highest + 1
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
