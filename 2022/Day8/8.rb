file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day8_1
    trees = Hash.new(0)
    $lines.each_with_index do |r, ri|
        r.chars.each_with_index do |c, ci|
            trees[[ci, ri]] = c
        end
    end
    trees.freeze
    num_rows = $lines.length
    num_cols = $lines[0].length
    trees.each do |(ci, ri), v|
        left = [[*((ci - 1)...ci)].product([ri]), [*((ci + 1)...num_cols)].product([ri]), [ci].product([*((ri - 1)...ri)]), [ci].product([*((ri + 1)...num_rows)])]
        pp left
        return
        
        # .map{|coord| trees[coord]}.max
        # right = [*((ci + 1)...num_cols)].product([ri]).map{|coord| trees[coord]}.max
        #     [ci].product([*((ri - 1)...ri), *((ri + 1)...num_rows)])
        # return
    end
end

def day8_2
end

pp day8_1
pp day8_2
