file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def transform(subject, subject_number, count)
    count.times do
        subject *= subject_number
    end
    subject %= 20201227
end

def day25_1
    card_subject = $lines[0].to_i
    door_subject = $lines[1].to_i

    door_loop = 0
    door_val = 1
    while door_val != door_subject
        door_val *= 7
        door_val %= 20201227
        door_loop += 1
    end

    encrypt_val = 1
    door_loop.times do
        encrypt_val *= card_subject
        encrypt_val %= 20201227
    end

    encrypt_val
end

def day25_2
    return "Deposit of 50 Stars payed! <3"
end

puts day25_1
puts day25_2

