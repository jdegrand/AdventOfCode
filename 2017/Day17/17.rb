file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

class LinkedList
    def initialize(value, step_size)
        node = Node.new(value)
        @head = node
        @head.next = head
        @step_size = step_size
    end

    def insert(value)
        node = Node.new(value)
        @step_size.times{ @head = @head.next }
        old_head = @head
        @head = node
        node.next = old_head.next
        old_head.next = node
    end

    def print
        curr = @head.next
        tail_values = []
        until curr == @head
            tail_values += [curr.value]
            curr = curr.next
        end

        puts "(#{curr.value}) #{tail_values.join(" ")}"
    end
    
    attr_accessor :head
end

class Node
    def initialize(value)
        @value = value
        @next = nil
    end

    attr_accessor :value
    attr_accessor :next
end


def day17_1
    step_size = $lines[0].to_i
    spinlock = LinkedList.new(0, step_size)
    (1..2017).each do |v|
        spinlock.insert(v)
    end
    spinlock.head.next.value
end

def day17_2
    step_size = $lines[0].to_i
    current_index = 0
    after_zero = 0
    (1..50000000).each do |v|
        current_index = ((current_index + step_size) % v) + 1
        after_zero = v if current_index == 1
    end
    after_zero
end

pp day17_1
pp day17_2
