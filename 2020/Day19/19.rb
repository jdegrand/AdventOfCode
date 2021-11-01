require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n")

def evaluate(rules, rule)
    if rules[rule][0] == "a" || rules[rule][0] == "b"
        return rules[rule]
    end
    if rules[rule].is_a?(Array)
        poss = []
        rules[rule].each_with_index do |r, i|
            r.each_with_index do |n, j|
                if j == 0
                    poss += [evaluate(rules, n)]
                else
                    poss[i] = poss[i].product([evaluate(rules, n)])
                end
            end
        end
        return poss.map{|p| p}
    end
end

def day19_1
    rules = {}
    reg = /\A(\d+): (.+)\Z/
    base = /\A(\d+): "([ab])"\Z/
    queue = []
    visited = Set.new
    $lines[0].split("\n").map(&:chomp).each do |l|
        if base =~ l
            key, letter = l.match(base).captures
            rules[key.to_i] = letter
            queue << key.to_i
            visited << key.to_i
            next
        end
        key, v1  = l.match(reg).captures
        key = key.to_i
        rules[key] = v1.split(" | ").map{|s| "(" + s.split.map{|n| ".#{n}."}.join(" ") + ")"}.join("|") 
    end
    while queue.length != 0
        c = queue.shift
        rules.each do |k, v|
            if v.gsub!("." + c.to_s + ".", "(" + rules[c] + ")")
                if !visited.include?(k) && !(/\d+/ =~ v)
                    queue << k
                    visited << k
                end
            end
        end
    end
    rules.each do |k, v|
        rules[k] = Regexp.new("^" + v.gsub(" ", "") + "$")
    end
    $lines[1].split("\n").map(&:chomp).each.filter{|r| rules[0] =~ r}.count
end


# 8: 42 | 42 8
# 11: 42 31 | 42 11 31
def day19_2
    rules = {}
    reg = /\A(\d+): (.+)\Z/
    base = /\A(\d+): "([ab])"\Z/
    queue = []
    visited = Set.new
    $lines[0].split("\n").map(&:chomp).each do |l|
        if base =~ l
            key, letter = l.match(base).captures
            rules[key.to_i] = letter
            queue << key.to_i
            visited << key.to_i
            next
        end
        key, v1  = l.match(reg).captures
        key = key.to_i
        rules[key] = v1.split(" | ").map{|s| "(" + s.split.map{|n| ".#{n}."}.join(" ") + ")"}.join("|") 
    end
    rules[8] = "((.42.)+)"
    rules[11] = "(?<rec>\.42\. \\g<rec>?\.31\.)"
    while queue.length != 0
        c = queue.shift
        rules.each do |k, v|
            if v.gsub!("." + c.to_s + ".", "(" + rules[c] + ")")
                if !visited.include?(k) && !(/\d+/ =~ v)
                    queue << k
                    visited << k
                end
            end
        end
    end
    rules.each do |k, v|
        rules[k] = Regexp.new("^" + v.gsub(" ", "") + "$")
    end
    $lines[1].split("\n").map(&:chomp).each.filter{|r| rules[0] =~ r}.count
end

puts day19_1
puts day19_2
