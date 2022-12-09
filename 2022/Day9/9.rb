file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day9_1
    head = [0, 0]
    tail = [0, 0]
    visited = Hash.new(0)
    $lines.map(&:split).each do |dir, s_num|
        num = s_num.to_i
        num.times do 
            case dir
            when ?R
                head = [head[0] + 1, head[1]]
            when ?L
                head = [head[0] - 1, head[1]]
            when ?U
                head = [head[0], head[1] + 1]
            when ?D
                head = [head[0], head[1] - 1]
            end
            if [-1, 0, 1].product([-1, 0, 1]).map{|dx, dy| [tail[0] + dx, tail[1] + dy]}.none?{|coord| coord == head}
                case dir
                when ?R
                    tail = [head[0] - 1, head[1]]
                when ?L
                    tail = [head[0] + 1, head[1]]
                when ?U
                    tail = [head[0], head[1] - 1]
                when ?D
                    tail = [head[0], head[1] + 1]
                end
            end
            visited[tail] += 1
        end
    end
    visited.length
end

def day9_2
    visited = Hash.new(0)
    knot_pos = {}
    (0..9).each{|n| knot_pos[n] = [0, 0]}
    $lines.map(&:split).each do |dir, s_num|
        num = s_num.to_i
        num.times do |t|
            case dir
            when ?R
                knot_pos[0] = [knot_pos[0][0] + 1, knot_pos[0][1]]
            when ?L
                knot_pos[0] = [knot_pos[0][0] - 1, knot_pos[0][1]]
            when ?U
                knot_pos[0] = [knot_pos[0][0], knot_pos[0][1] + 1]
            when ?D
                knot_pos[0] = [knot_pos[0][0], knot_pos[0][1] - 1]
            end
            pp "#{num}: #{t+1}"
            # num.times do
                ((t + 1)..9).each do |sn|
                    if [-1, 0, 1].product([-1, 0, 1]).map{|dx, dy| [knot_pos[sn][0] + dx, knot_pos[sn][1] + dy]}.none?{|coord| coord == knot_pos[sn - 1]}
                        case dir
                        when ?R
                            knot_pos[sn] = [knot_pos[sn - 1][0] - 1, knot_pos[sn - 1][1]]
                        when ?L
                            knot_pos[sn] = [knot_pos[sn - 1][0] + 1, knot_pos[sn - 1][1]]
                        when ?U
                            knot_pos[sn] = [knot_pos[sn - 1][0], knot_pos[sn - 1][1] - 1]
                        when ?D
                            knot_pos[sn] = [knot_pos[sn - 1][0], knot_pos[sn - 1][1] + 1]
                        end
                    end
                    pp "#{sn}: #{knot_pos[sn]}"

                    visited[knot_pos[sn]] += 1 if sn == 9
                end
            # end
            puts
        end
        return if dir == "U"
    end
    visited.length
end

pp day9_1
pp day9_2
