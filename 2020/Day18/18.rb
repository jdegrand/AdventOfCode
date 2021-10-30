file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)


# ((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2

def evaluate(exp)
    index = 0
    p = 0
    case exp[index]
    when ?(
        start_paren = index
        p += 1
        index += 1
        while p != 0
            case exp[index]
            when ?(
                p += 1
            when ?)
                p -= 1
            end
            index += 1
        end
        end_paren = index - 1
        if exp[index].nil?
            return evaluate(exp[start_paren+1...end_paren])
        end
        if exp[index] == ?+
            return evaluate(exp[start_paren+1...end_paren]) + evaluate(exp[(index+1)..])
        else
            return evaluate(exp[start_paren+1...end_paren]) * evaluate(exp[(index+1)..])
        end
    else
        if exp[index+1].nil?
            return (exp[index].to_i)
        end
        if exp[index+1] == ?+
            return exp[index].to_i + evaluate(exp[(index+2)..])
        else
            return exp[index].to_i * evaluate(exp[(index+2)..])
        end
    end
end

def day18_1
    $lines.map{|l| evaluate(l.split(" ").join.reverse.gsub(?), ?_).gsub(?(, ?)).gsub(?_, ?())}.sum
end

class Opposite
    def initialize(n)
        @num = n
    end
    attr_reader :num  
    
    def +(n)
      return Opposite.new(self.num * n.num)
    end
    
    def *(n)
      return Opposite.new(self.num + n.num)
    end
end

def day18_2
    $lines.map{|l| eval(l.split(" ").join.chars.map{|c|
        c.match(/\d/) ? "Opposite.new(#{c})" : c
    }.join.gsub(?+, ?_).gsub(?*, ?+).gsub(?_, ?*)).num}.sum
end

puts day18_1
puts day18_2

