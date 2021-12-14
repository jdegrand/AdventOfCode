file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day14_1
    poly = "NNCB"
    polys = [poly]
    rules = {}
    $lines.each do |l|
        l, r = l.split(" -> ")
        rules[l] = r
    end
    10.times do
        new_poly = poly[0]
        poly.chars.each_cons(2) do |x|
            new_poly += rules[x.join] + x[1]
        end
        poly = new_poly
    end
    counts = Hash.new(0)
    poly.chars.each do |c|
        counts[c] += 1
    end
    min, max = counts.map{|_, v| v}.minmax
    max - min
end

class Node
    def initialize(value)
        @value = value
        @next = nil
    end

    attr_accessor :value
    attr_accessor :next
end

class Linked
    def initialize(head, rules)
        @head = head
        @tail = head
        @rules = rules
        @length = 1
    end

    def insert(node)
        @tail.next = node
        @tail = node
        @length += 1
    end

    def step
        left = @head
        right = left.next
        until right == nil
            to_add = Node.new(@rules[[left.value, right.value].join])
            left.next = to_add
            to_add.next = right
            left = right
            right = left.next
            @length += 1
        end
    end

    def get_result
        counts = Hash.new(0)
        temp = @head
        until temp == nil
            counts[temp.value] += 1
            temp = temp.next 
        end
        min, max = counts.map{|_, v| v}.minmax
        max - min
        counts.sort_by{|k, v| k}
        # counts
        # [min, max]
    end

    def print
        pol = ""
        temp = @head
        until temp == nil
            pol += temp.value
            temp = temp.next 
        end
        pp pol
    end

    attr_accessor :head
    attr_accessor :length
end

def day14_2
    poly_string = "NNSOFOCNHBVVNOBSBHCB"
    rules = {}
    $lines.each do |l|
        l, r = l.split(" -> ")
        rules[l] = r
    end

    prev = nil
    poly = Linked.new(Node.new(poly_string[0]), rules);
    poly_string[1..].chars.each do |c|
       node = Node.new(c)
       poly.insert(node)
    end

    results = []
    10.times do |t|
        poly.step
        results << poly.get_result
        pp "#{t} #{results[-1]}"
    end
    results
end

pp day14_1
pp day14_2

# res = [5,
# 10,
# 23,
# 54,
# 104,
# 216,
# 462,
# 935,
# 1922,
# 3906,
# 8042,
# 16200,
# 32818,
# 65868,
# 132545,
# 265621,
# 532278,
# 1065347,
# 2131750,
# 4263987]

# res.each do |r1|
#     res.each do |r2|
#         if r1 != r2
#             pp "#{r1}, #{r2}" if r1 % r2 == 0
#             pp "#{r1}, #{r2}" if r2 % r1 == 0
#         end
#     end
# end