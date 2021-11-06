require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n")

def day22_1
    p1 = $lines[0].split("\n")[1..].map(&:chomp).map(&:to_i)
    p2 = $lines[1].split("\n")[1..].map(&:chomp).map(&:to_i)
    while !p1.empty? && !p2.empty?
        p1c = p1.shift
        p2c = p2.shift
        if p1c > p2c then p1 << p1c << p2c end
        if p2c > p1c then p2 << p2c << p1c end
    end
    winner = p1.empty? ? p2 : p1
    winner = winner.reverse
    winner.each_with_index.map{|n, i| n*(i+1)}.sum
end

def recursiveCombat(p1, p2, game)
    winner = nil
    games = Set.new
    # pp "Game #{game}: #{p1}, #{p2}"
    round = 1
    while !p1.empty? && !p2.empty?
        # pp "Round: #{round}, #{p1}, #{p2}"
        # sleep(1)
        if games.include?([p1, p2]) then return :p1 end
        games << [p1, p2]
        p1c = p1.shift
        p2c = p2.shift
        if p1c <= p1.length && p2c <= p2.length
            winner = recursiveCombat(p1.map(&:clone)[0...p1c], p2.map(&:clone)[0...p2c], game + 1)
            if winner == :p1 then p1 << p1c << p2c end
            if winner == :p2 then p2 << p2c << p1c end
        else
            if p1c > p2c then p1 << p1c << p2c end
            if p2c > p1c then p2 << p2c << p1c end
        end
        round += 1
    end
    return p1.empty? ? :p2 : :p1
end

def day22_2
    p1 = $lines[0].split("\n")[1..].map(&:chomp).map(&:to_i)
    p2 = $lines[1].split("\n")[1..].map(&:chomp).map(&:to_i)
    winner = recursiveCombat(p1, p2, 1)
    winning_cards = winner == :p1 ? p1 : p2
    winning_cards = winning_cards.reverse
    winning_cards.each_with_index.map{|n, i| n*(i+1)}.sum
end

puts day22_1
pp day22_2

