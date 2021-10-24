require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.split("\n").map(&:to_i)

def day9_1(pn)
    preamble = $lines[0...(pn+1)]
    $lines[(pn+1)..].each do |n|
        s = Set.new
        found = false
        preamble.each do |p|
            if s.include?(n - p)
                found = true
                break
            end
            s << p
        end
        if found
            preamble.shift
            preamble << n
        else
            return n
        end
    end
end

def day9_2(n)
    l = 0
    r = 1
    sum = $lines[l..r].sum
    while true
        if sum == n then return $lines[l..r].min + $lines[l..r].max end
        if sum > n
            sum -= $lines[l]
            l += 1
        else
            r += 1
            sum += $lines[r]
        end
        if l == r then r += 1 end
    end
end

part1 = day9_1(25)
puts part1
puts day9_2(part1)

