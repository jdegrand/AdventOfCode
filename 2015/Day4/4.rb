require 'digest'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day4_1
    (0..1000000).each do |i|
        hex = Digest::MD5.hexdigest "#{$lines[0]}#{i}"
        return i if hex.start_with?("00000")
    end
end

def day4_2
    (0..10000000).each do |i|
        hex = Digest::MD5.hexdigest "#{$lines[0]}#{i}"
        return i if hex.start_with?("000000")
    end
end

pp day4_1
pp day4_2
