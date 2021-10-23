file = "input.txt"
input = File.read(file)

$pass = []

input.lines.map(&:chomp).each do |l|
    $pass << l
end

def day2_1
    total = 0
    $pass.each do |p|
        range, letter, pass = p.split
        letter = letter[0...-1]
        min, max = range.split("-").map(&:to_i)
        letters = 0
        pass.split("").each do |l|
            if l == letter
                letters += 1
            end
        end
        if letters >= min and letters <= max
            total += 1
        end
    end
    puts total
end

def day2_2
    total = 0
    $pass.each do |p|
        range, letter, pass = p.split
        letter = letter[0...-1]
        min, max = range.split("-").map(&:to_i)
        if (pass[min-1] == letter) ^ (pass[max-1] == letter)
            total += 1
        end
    end
    puts total
end

day2_1
day2_2
