file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day3_1
    g = ""
    (0...$lines[0].length).to_a.each do |i|
        ones = $lines.map{|l| l[i]}.count("1")
        zeros = $lines.map{|l| l[i]}.count("0")
        if ones > zeros
            g += "1"
        else
            g += "0"
        end
    end
    g.to_i(2) * g.split("").map{|n| n == "1" ? "0" : "1"}.join.to_i(2)
end

def day3_2
    bits = $lines.map(&:clone)
    sbits = $lines.map(&:clone)
    (0...$lines[0].length).to_a.each do |i|
        ones = bits.map{|l| l[i]}.count("1")
        zeros = bits.map{|l| l[i]}.count("0")
        if ones < zeros
            bits = bits.filter{|l| l[i] == "0"}
        else
            bits = bits.filter{|l| l[i] == "1"}
        end
        break if bits.length == 1
    end

    (0...$lines[0].length).to_a.each do |i|
        ones = sbits.map{|l| l[i]}.count("1")
        zeros = sbits.map{|l| l[i]}.count("0")
        if ones >= zeros
            sbits = sbits.filter{|l| l[i] == "0"}
        else
            sbits = sbits.filter{|l| l[i] == "1"}
        end
        break if sbits.length == 1
    end
    bits[0].to_i(2) * sbits[0].to_i(2)
end

pp day3_1
pp day3_2

