file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day21_1
    p1 = $lines[0].split[-1].to_i
    p2 = $lines[1].split[-1].to_i
    p1_score = 0
    p2_score = 0
    turn = 1
    counter = 1
    until p1_score >= 1000 || p2_score >= 1000
        spaces = 0
        if counter == 98
            spaces = 98 + 99 + 100
            counter = 1
        elsif counter == 99
            spaces = 99 + 100 + 1
            counter = 2
        elsif counter == 100
            spaces = 100 + 1 + 2
            counter = 3
        else
            spaces = counter + counter + 1 + counter + 2
            counter += 3
        end
        if turn % 2 != 0
            p1 += spaces % 10
            p1 -= 10 if p1 > 10
            p1_score += p1
        else
            p2 += spaces % 10
            p2 -= 10 if p2 > 10
            p2_score += p2
        end
        turn += 1
    end
    score = p1_score < p2_score ? p1_score : p2_score
    score * (turn - 1) * 3
end

$ways = [1,2,3].product([1,2,3], [1,2,3]).map(&:sum).tally

def next_turn(p1_in, p1_score_in, p2_in, p2_score_in, turn, dp)
    return [1, 0] if p1_score_in >= 21
    return [0, 1] if p2_score_in >= 21
    return dp[[p1_in, p1_score_in, p2_in, p2_score_in, turn]] if dp.key?([p1_in, p1_score_in, p2_in, p2_score_in, turn])
    universe_wins = [0, 0]
    $ways.each do |k, v|
        p1 = p1_in
        p1_score = p1_score_in
        p2 = p2_in
        p2_score = p2_score_in
        if turn % 2 != 0
            p1 += k
            p1 -= 10 if p1 > 10
            p1_score += p1
        else
            p2 += k
            p2 -= 10 if p2 > 10
            p2_score += p2
        end
        p1s, p2s = next_turn(p1, p1_score, p2, p2_score, turn + 1, dp)
        universe_wins[0] += v * p1s
        universe_wins[1] += v * p2s
    end
    dp[[p1_in, p1_score_in, p2_in, p2_score_in, turn]] = universe_wins
    universe_wins
end

def day21_2
    p1 = $lines[0].split[-1].to_i
    p2 = $lines[1].split[-1].to_i
    p1_score = 0
    p2_score = 0
    turn = 1
    dp = {}
    next_turn(p1, p1_score, p2, p2_score, turn, dp).max
end

pp day21_1
pp day21_2
