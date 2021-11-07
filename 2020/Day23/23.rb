require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day23_1
    cups = $lines[0].chars.map(&:to_i)
    min, max = cups.minmax
    100.times do |i|
        index = i % cups.length
        current = cups[index]
        dest = current == min ? max : current - 1
        pickup = []
        if index >= cups.length - 3
            pickup += cups[(index + 1)..] + cups[0..(3 - (cups.length - index))]
        else
            pickup = cups[(index + 1)..(index + 3)]
        end
        while pickup.include?(dest)
            dest = dest == min ? max : dest - 1
        end
        pickup.map{|c| cups.delete(c)}
        new_cups = []
        curr_index = cups.index(current)
        (curr_index...(cups.length + curr_index)).each do |j|
            new_cups << cups[j % cups.length]
            if cups[j % cups.length] == dest then new_cups += pickup end
        end
        cups = new_cups.rotate(-index)
    end
    cups.map(&:to_s).join.split("1").reverse.join
end

class LinkedList
    def initialize(arr)
        curr = Node.new(arr[0])
        curr.next = curr
        @index = curr
        @tail = curr
        @length = 1
        arr[1..].each do |n|
            temp = Node.new(n)
            @tail.next = temp
            temp.next = @index
            @tail = temp
            @length += 1
        end
    end

    def pickup
        pickup = @index.next
        pickup_end  = pickup.next.next
        @index.next = pickup_end.next
        pickup_end.next = nil

        @length -= 3

        pickup
    end

    def updateIndex
        @index = @index.next
    end
    
    attr_accessor :head
    attr_accessor :tail
    attr_accessor :index
    attr_accessor :length
end

class Node
    def initialize(value)
        @value = value
        @next = nil
    end

    attr_accessor :value
    attr_accessor :next
end

def day23_2
    cupsId = {}
    cups = $lines[0].chars.map(&:to_i)
    cups += ((cups.max+1)..1000000).to_a
    min, max = cups.minmax
    cups = LinkedList.new(cups)
    start = cups.index
    cupsId[start.value] = start
    start = start.next
    while start != cups.index
        cupsId[start.value] = start
        start = start.next
    end
    10000000.times do |i|
        current = cups.index.value
        pickup = cups.pickup
        dest = current == min ? max : current - 1
        while dest == pickup.value || dest == pickup.next.value || dest == pickup.next.next.value 
            dest = dest == min ? max : dest - 1
        end
        destCup = cupsId[dest]
        temp = destCup.next
        destCup.next = pickup
        pickup.next.next.next = temp
        cups.updateIndex
    end
    cupsId[1].next.value * cupsId[1].next.next.value
end

puts day23_1
puts day23_2

