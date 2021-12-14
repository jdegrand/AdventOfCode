require 'set'

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

def day14_2
    adj = Hash.new(0)
    poly_string = "NNSOFOCNHBVVNOBSBHCB"
    rules = {}
    letters = Hash.new(0)
    $lines.each do |l|
        l, r = l.split(" -> ")
        rules[l] = r
    end

    poly_string.chars.each_cons(2) do |x|
        adj[x.join] += 1
    end
    
    new_adj = []
    40.times do |t|
        new_adj = Hash.new(0)
        adj.each do |k, v|
            new_adj[[k[0], rules[k]].join] += v
            new_adj[[rules[k], k[1]].join] += v
            letters[rules[k]] += v
        end
        adj = new_adj
    end
    min, max = letters.map{|_, v| v}.minmax
    max - min
end

pp day14_1
pp day14_2



# EXTRA CODE

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