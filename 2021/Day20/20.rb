file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day20(n)
    bin = $lines[0]
    start_pixels = Hash.new(?.)
    rows = 0
    cols = $lines[2].length
    $lines[2..].each_with_index do |row, i|
        row.chars.each_with_index do |chr, j|
            start_pixels[[i, j]] = chr
        end
        rows += 1
    end
    rows = [0, rows]
    cols = [0, cols]

    pixels = start_pixels.clone
    n.times do |t|
        new_pixels = t % 2 != 0 ? Hash.new(?.) : Hash.new(?#)
        (rows[0] - 1).upto(rows[1]).to_a.each do |r|
            (cols[0] - 1).upto(cols[1]).to_a.each do |c|
                adj = [[r - 1, c - 1], [r - 1, c], [r - 1, c + 1], [r, c - 1], [r, c], [r, c + 1], [r + 1, c - 1], [r + 1, c], [r + 1, c + 1]]
                binary = adj.map{|l| pixels[l]}.reduce(:+).gsub(?., ?0).gsub(?#, ?1).to_i(2)
                new_pixels[[r, c]] = bin[binary]
            end
        end
        rows = [rows[0] - 1, rows[1] + 1]
        cols = [cols[0] - 1, cols[1] + 1]
        pixels = new_pixels.clone
    end
    pixels.count{|_, v| v == ?#}
end

pp day20(2)
pp day20(50)
