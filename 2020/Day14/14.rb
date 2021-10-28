file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def maskInt(mask, n)
    s = ""
    n = ('%36.36s' % n).gsub(' ', '0')
    mask.chars.each_with_index do |m, i|
       s += m == ?X ? n[i] : m
    end
    s
end

def maskInt2(mask, n)
    s = ""
    n = ('%36.36s' % n).gsub(' ', '0')
    floats = []
    mask.chars.each_with_index do |m, i|
        case m
        when ?X
            s += ?X
            floats += [i]
        when ?0
            s += n[i]
        when ?1
            s += ?1
        end
    end
    bits = generateBits(floats.length)
    mem_loc = []
    bits.each do |b|
        s_temp = s
        floats.zip(b.chars).each do |i, v|
           s_temp[i] = v 
        end
        mem_loc << s_temp.dup
    end
    mem_loc
end

def generateBits(n)
    b = 2**n - 1
    bits = []
    (0..b).each do |r|
        bits += ["%0#{n}b" % r]
    end
    bits
end

def day14_1
    mem = {}
    mask = nil
    reg = /\Amem\[(\d+)\] = (\d+)\Z/
    $lines.each do |l|
        if l[0..3] == "mask"
            mask = l[7..]
            next
        end
        loc, val = l.match(reg).captures.map(&:to_i)
        mem[loc] = maskInt(mask, val.to_s(2)).to_i(2)
    end
    mem.map{|_, v| v}.sum
end

def day14_2
    mem = {}
    mask = nil
    reg = /\Amem\[(\d+)\] = (\d+)\Z/
    $lines.each do |l|
        if l[0..3] == "mask"
            mask = l[7..]
            next
        end
        loc, val = l.match(reg).captures.map(&:to_i)
        maskInt2(mask, loc.to_s(2)).map{|l| l.to_i(2)}.each do |m|
            mem[m] = val
        end
    end
    mem.map{|_, v| v}.sum
end

puts day14_1
puts day14_2

