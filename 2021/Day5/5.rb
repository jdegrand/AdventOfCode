file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day5_1
    lin = Hash.new(0)
    $lines.each do |l|
        s, _, e = l.split
        s = s.split(",")
        s = [s[0].to_i, s[1].to_i]
        e = e.split(",")
        e = [e[0].to_i, e[1].to_i]

        if (e[0] == s[0]) || (e[1] == s[1])
            if e[0] == s[0]
                aa = s[1] > e[1] ? (e[1]..s[1]) : (s[1]..e[1])
                aa.to_a.each do |c|
                    lin[[e[0], c]] += 1
                end
            else
                aa = s[0] > e[0] ? (e[0]..s[0]) : (s[0]..e[0])
                aa.to_a.each do |c|
                    lin[[c, e[1]]] += 1
                end
            end
        end
    end

    lin.count{|_, c| c >= 2}
end

def day5_2
    lin = Hash.new(0)
    $lines.each do |l|
        s, _, e = l.split
        s = s.split(",")
        s = [s[0].to_i, s[1].to_i]
        e = e.split(",")
        e = [e[0].to_i, e[1].to_i]

        if (e[0] == s[0]) || (e[1] == s[1])
            if e[0] == s[0]
                aa = s[1] > e[1] ? (e[1]..s[1]) : (s[1]..e[1])
                aa.to_a.each do |c|
                    lin[[e[0], c]] += 1
                end
            else
                aa = s[0] > e[0] ? (e[0]..s[0]) : (s[0]..e[0])
                aa.to_a.each do |c|
                    lin[[c, e[1]]] += 1
                end
            end
        else
            dr = (e[0] - s[0])/(e[0] - s[0]).abs
            dc = (e[1] - s[1])/(e[1] - s[1]).abs
            curr = s
            until curr == e
                lin[curr] += 1 
                curr = [curr[0] + dr, curr[1] + dc]  
            end
            lin[e] += 1
        end
    end

    lin.count{|_, c| c >= 2}
end

pp day5_1
pp day5_2
