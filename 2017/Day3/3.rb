file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)[0].to_i

def day3_helper(width, current)
    half = (width - 1) / 2    
    current = (width - 2) ** 2 + 1

    # right side
    row, col = [-half, half]
    (-half + 1).upto(half).each do |r|
        return [r, col] if current == $lines
        current += 1
    end

    # top side
    row, col = [half, half]
    current -= 1
    half.downto(-half).each do |c|
        return [row, c] if current == $lines
        current += 1
    end

    # left side
    row, col = [half, -half]
    current -= 1
    half.downto(-half).each do |r|
        return [r, col] if current == $lines
        current += 1
    end

    # bottom side
    row, col = [-half, -half]
    current -= 1
    (-half).upto(half).each do |c|
        return [row, c] if current == $lines
        current += 1
    end
end

# 17  16  15  14  13
# 18   5   4   3  12
# 19   6   1   2  11
# 20   7   8   9  10
# 21  22  23---> ...
def day3_1
    width = 1
    max_on_grid = 1
    while max_on_grid < $lines
        width += 2
        max_on_grid = width ** 2
    end
    half = (width - 1) / 2    
    current = (width - 2) ** 2 + 1

    day3_helper(width, current).map(&:abs).inject(:+)
end

# 147  142  133  122   59
# 304    5    4    2   57
# 330   10    1    1   54
# 351   11   23   25   26
# 362  747  806  854  905  931 ...
def day3_2

end

pp day3_1
pp day3_2

