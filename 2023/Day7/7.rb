
file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day7_1
    card_points = {}
    %w(A K Q J T 9 8 7 6 5 4 3 2).reverse.each_with_index{ card_points[_1] = _2 }
    rank_points = {}
    ranks = [ :five, :four, :full_house, :three, :two_pair, :one_pair, :high ].reverse.each_with_index{ rank_points[_1] = _2 }
    $lines.map { |l|
        hand, bid = l.split
        score = :high
        tally = hand.chars.tally
        if tally.any?{ _2 == 5 }
            score = :five
        elsif tally.any?{ _2 == 4 }
            score = :four
        elsif tally.any?{ _2 == 3 } && tally.any?{ _2 == 2}
            score = :full_house
        elsif tally.any?{ _2 == 3 }
            score = :three
        elsif tally.filter{ _2 == 2 }.size == 2
            score = :two_pair
        elsif tally.any?{ _2 == 2}
            score = :one_pair 
        end
        [score, hand, bid]
    }.sort { |h1, h2|
        score1, hand1, _ = h1
        score2, hand2, _ = h2
        [rank_points[score1], hand1.chars.map{|card| card_points[card]}] <=> [rank_points[score2], hand2.chars.map{|card| card_points[card]}]
    }.map.with_index(1){|hand_info, index| hand_info[2].to_i * index }.sum
end

def day7_2
    card_points = {}
    rank_points = {}
    %w(A K Q T 9 8 7 6 5 4 3 2 J).reverse.each_with_index{ card_points[_1] = _2 }
    ranks = [ :five, :four, :full_house, :three, :two_pair, :one_pair, :high ].reverse.each_with_index{ rank_points[_1] = _2 }
    tally_sets = {
        1 => {
            [4] => :five,
            [3, 1] => :four,
            [2, 2] => :full_house,
            [2, 1, 1] => :three,
            [1, 1, 1, 1] => :one_pair
        },
        2 => {
            [3] => :five,
            [2, 1] => :four,
            [1, 1, 1] => :three
        },
        3 => {
            [2] => :five,
            [1, 1] => :four
        },
        4 => {
            [1] => :five
        }
    }
    
    $lines.map { |l|
        hand, bid = l.split
        score = :high
        tally = hand.chars.tally
        if tally[?J] && tally[?J] != 5
            jokers = tally.delete(?J)
            score = tally_sets[jokers][tally.values.sort.reverse]
        else
            if tally.any?{ _2 == 5 }
                score = :five
            elsif tally.any?{ _2 == 4 }
                score = :four
            elsif tally.any?{ _2 == 3 } && tally.any?{ _2 == 2}
                score = :full_house
            elsif tally.any?{ _2 == 3 }
                score = :three
            elsif tally.filter{ _2 == 2 }.size == 2
                score = :two_pair
            elsif tally.any?{ _2 == 2}
                score = :one_pair 
            end
        end
        [score, hand, bid]
    }.sort { |h1, h2|
        score1, hand1, _ = h1
        score2, hand2, _ = h2
        [rank_points[score1], hand1.chars.map{|card| card_points[card]}] <=> [rank_points[score2], hand2.chars.map{|card| card_points[card]}]
    }.map.with_index(1){|hand_info, index| hand_info[2].to_i * index }.sum
end

pp day7_1
pp day7_2
