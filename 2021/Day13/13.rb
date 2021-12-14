file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n")

def day13_1
    paper = Hash.new(?.)
    minx = 1.0 / 0
    miny = 1.0 / 0
    maxx = -1.0 / 0
    maxy = -1.0 / 0

    $lines[0].split("\n").each do |l|
        x, y = l.chomp.split(?,).map(&:to_i)
        paper[[x, y]] = ?#
        minx = [minx, x].min
        maxx = [maxx, x].max
        miny = [miny, y].min
        maxy = [maxy, y].max
    end
    instructions = $lines[1].split("\n")
    inst = instructions[0].split[-1]
    dir, bound = inst.split("=")
    bound = bound.to_i
    if dir == ?y
        (bound+1..maxy).each do |y|
            (minx..maxx).each do |x|
                paper[[x, y - ((y - bound) * 2)]] = ?# if paper[[x, y]] == ?#
                paper.delete([x, y])
            end
        end
    else
        (miny..maxy).each do |y|
            (bound+1..maxx).each do |x|
                paper[[x - ((x - bound) * 2), y]] = ?# if paper[[x, y]] == ?#
                paper.delete([x, y])
            end
        end
    end
    paper.count{|k, v| v == ?#}
end

def day13_2
    paper = Hash.new(?.)
    minx = 1.0 / 0
    miny = 1.0 / 0
    maxx = -1.0 / 0
    maxy = -1.0 / 0
    $lines[0].split("\n").each do |l|
        x, y = l.chomp.split(?,).map(&:to_i)
        paper[[x, y]] = ?#
        minx = [minx, x].min
        maxx = [maxx, x].max
        miny = [miny, y].min
        maxy = [maxy, y].max
    end
    instructions = $lines[1].split("\n")
    instructions.each do |i|
        inst = i.split[-1].chomp
        dir, bound = inst.split("=")
        bound = bound.to_i
        if dir == ?y
            (bound+1..maxy).each do |y|
                (minx..maxx).each do |x|
                    paper[[x, y - ((y - bound) * 2)]] = ?# if paper[[x, y]] == ?#
                    paper.delete([x, y])
                end
            end
            maxy = bound - 1
        else
            (miny..maxy).each do |y|
                (bound+1..maxx).each do |x|
                    paper[[x - ((x - bound) * 2), y]] = ?# if paper[[x, y]] == ?#
                    paper.delete([x, y])
                end
            end
            maxx = bound - 1
        end
    end
    (miny..maxy).each do |y|
        row = ""
        (minx..maxx).each do |x|
            row += paper[[x, y]]
        end
        puts row.gsub(?., "  ").gsub(?#, ?⬜)
    end
end

pp day13_1
day13_2
