require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n").map(&:chomp)

def day4_1
    valid = Set['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
    valid_count = 0
    $lines.each do |l|
        s = Set.new
        keys = l.split("\n").join(" ").split.map{|p| p.split(":")[0]}
        keys.map{|k| s << k}
        if valid ^ s == Set.new or valid ^ s == Set['cid']
            valid_count += 1
        end
    end
    valid_count
end

def day4_2
    valid = Set['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
    valid_count = 0
    $lines.each do |l|
        s = Set.new
        keys = l.split("\n").join(" ").split.map{|p| p.split(":")}
        bad = false
        keys.each do |k, v|
            case k
            when 'byr'
                next unless (1920..2002).include?(v.to_i); 
            when 'iyr'
                next unless (2010..2020).include?(v.to_i);
            when 'eyr'
                next unless (2020..2030).include?(v.to_i);
            when 'hgt'
                next unless (v.end_with?("cm") and (120..193).include?(v[0...-2].to_i)) or (v.end_with?("in") and (59..76).include?(v[0...-2].to_i)) 
            when 'hcl'
                next unless v.start_with?("#")
                next unless v[1..].length == 6
                chars = Set[*'0'..'9', *'a'..'z']
                next unless v[1..].chars.map{|c| chars.include?(c)}.all?
            when 'ecl'
                next unless Set['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include?(v)
            when 'pid'
                next unless v.length == 9 and v.chars.map{|c| ('0'..'9').include?(c)}.all?
            end
            s << k
        end
        if valid ^ s == Set.new or valid ^ s == Set['cid']
            valid_count += 1
        end
    end
    valid_count
end

puts day4_1
puts day4_2

