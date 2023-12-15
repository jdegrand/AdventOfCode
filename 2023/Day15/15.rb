file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day15_1
    sequence = $lines[0].split(?,)
    sequence.map { |s|
        curr = 0
        s.chars.each{curr = ((curr + _1.ord) * 17) % 256}
        curr
    }.sum
end

def day15_2
    boxes = {}
    sequence = $lines[0].split(?,)
    sequence.map { |s|
        label, focal = s.split(?=)
        label = label[0...-1] if !focal
        curr = 0
        label.chars.each{curr = ((curr + _1.ord) * 17) % 256}
        boxes[curr] = {} if !boxes.key?(curr)
        if focal
            boxes[curr][label] = focal
        else
            boxes[curr].delete(label) if boxes[curr][label]
        end
    }
    boxes.map{|k, v| v.each_with_index.to_a.map{|(_, val), index| (k + 1) * (index + 1) * val.to_i}}.flatten.sum
end

pp day15_1
pp day15_2
