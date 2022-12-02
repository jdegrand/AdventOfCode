file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def getScore(me, opp, my_moves, opp_moves)
    my_index = my_moves.index(me)
    opp_index = opp_moves.index(opp)
    if my_index == opp_index
        return 3
    elsif (my_index + 1) % 3 == opp_index
        return 0
    else
        return 6
    end
end

def day2_1
    opp_moves = [?A, ?B, ?C]
    my_moves = [?X, ?Y, ?Z]
    score = 0
    $lines.each do |l|
        opp, me = l.split
        score += getScore(me, opp, my_moves, opp_moves) + my_moves.index(me) + 1
    end
    score
end

def getMove(me, opp, my_moves, opp_moves)
    case me
    when ?X
        return my_moves[(opp_moves.index(opp) - 1) % 3]
    when ?Y
        return my_moves[opp_moves.index(opp)]
    when ?Z
        return my_moves[(opp_moves.index(opp) + 1) % 3]
    end
end

def day2_2
    opp_moves = [?A, ?B, ?C]
    my_moves = [?X, ?Y, ?Z]
    score = 0
    $lines.each do |l|
        opp, me = l.split
        next_move = getMove(me, opp, my_moves, opp_moves)
        score += getScore(next_move,opp, my_moves, opp_moves) + my_moves.index(next_move) + 1
    end
    score
end

pp day2_1
pp day2_2
