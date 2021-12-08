require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day8_1
    sigs = []
    $lines.each do |l|
        sig, out = l.split(" | ")
        sigs << [sig.split, out.split]
    end
    valid = [2, 3, 4, 7]
    sigs.map{|s| s[1].count{|p| valid.include?(p.length)}}.sum
end

#                     Number 0 has 6 wires
#                     Number 1 has 2 wires
#      0000           Number 2 has 5 wires
#     5    1          Number 3 has 5 wires
#     5    1          Number 4 has 4 wires
#      6666           Number 5 has 5 wires 
#     4    2          Number 6 has 6 wires
#     4    2          Number 7 has 3 wires
#      3333           Number 8 has 0 wires
#                     Number 9 has 6 wires                 
def day8_2
    vals = []
    $lines.each do |l|
        wires = {}
        finalNums = {}
        sig, out = l.split(" | ")
        sig = sig.split
        out = out.split
        one = Set.new(sig.filter{|w| w.length == 2}[0].chars)
        four = Set.new(sig.filter{|w| w.length == 4}[0].chars)
        seven = Set.new(sig.filter{|w| w.length == 3}[0].chars)
        eight = Set.new(sig.filter{|w| w.length == 7}[0].chars)

        fourThree = eight - four - seven

        wires[0] = Set.new(sig.filter{|w| w.length == 3}[0].chars) - Set.new(sig.filter{|w| w.length == 2}[0].chars)
        wires[2] = sig.filter{|w| w.length == 6}.map{|s| Set.new(s.chars)}.reduce(:&) & one
        wires[1] = one - wires[2]
        wires[5] = Set.new(sig.filter{|w| w.length == 6 && (Set.new(w.chars) - fourThree - seven).length == 1}[0].chars) - fourThree - seven
        wires[6] = eight - seven - fourThree - wires[5]
        wires[3] = Set.new(sig.filter{|w| w.length == 5 && (Set.new(w.chars) - fourThree).length == 4}[0].chars) - seven - wires[5] - wires[6]
        wires[4] = eight - seven - four - wires[3]

        nums = {}
        nums[0] = eight - wires[6]
        nums[1] = one
        nums[2] = eight - wires[2] - wires[5]
        nums[3] = eight - wires[4] - wires[5]
        nums[4] = four
        nums[5] = eight - wires[1] - wires[4]
        nums[6] = eight - wires[1]
        nums[7] = seven
        nums[8] = eight
        nums[9] = eight - wires[4]
        val = out.map { |n|
            nums.filter{ |_, v|
                v == Set.new(n.chars)
            }.map{|k, _| k}[0].to_s
        }.join.to_i
        vals << val
    end  
    vals.sum
end

pp day8_1
pp day8_2