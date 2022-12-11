require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n")

class Monkey
    def initialize(id, items, op, cond, if_true, if_false)
        @id, @items, @op, @cond, @if_true, @if_false = id, items, op, cond, if_true, if_false
        @inspected = 0
        @seen
    end

    attr_accessor :id, :items, :op, :cond, :if_true, :if_false, :inspected
end

def day11_1
    monkeys = []
    $lines.each do |m|
        monkey = m.lines.map(&:chomp)
        number = monkey[0][...-1].split[-1].to_i
        items = monkey[1].split(": ")[1].split(", ").map(&:to_i)
        op = monkey[2].split(" = ")[1]
        cond = monkey[3].split[-1].to_i
        if_true = monkey[4].split[-1].to_i
        if_false = monkey[5].split[-1].to_i
        monkeys << Monkey.new(number, items, op, cond, if_true, if_false)
    end
    20.times do
        monkeys.each do |m|
            m.items.length.times do
                item = m.items.shift
                m.inspected += 1
                new_worry = eval(m.op.gsub("old", item.to_s)) / 3
                monkeys[new_worry % m.cond == 0 ? m.if_true : m.if_false].items << new_worry
            end
        end
    end
    monkeys.map{|m| m.inspected}.sort[-2..].inject(:*)
end

def day11_2
    monkeys = []
    $lines.each do |m|
        monkey = m.lines.map(&:chomp)
        number = monkey[0][...-1].split[-1].to_i
        items = monkey[1].split(": ")[1].split(", ").map(&:to_i)
        op = monkey[2].split(" = ")[1]
        cond = monkey[3].split[-1].to_i
        if_true = monkey[4].split[-1].to_i
        if_false = monkey[5].split[-1].to_i
        monkeys << Monkey.new(number, items, op, cond, if_true, if_false)
    end

    max_int_allowed = Set.new(monkeys.map{|m| m.cond}).inject(:*)

    10000.times do |t|
        monkeys.each do |m|
            m.items.length.times do
                item = m.items.shift
                m.inspected += 1
                new_worry = eval(m.op.gsub("old", item.to_s))
                monkeys[new_worry % m.cond == 0 ? m.if_true : m.if_false].items << (new_worry % max_int_allowed)
            end
        end
    end
    monkeys.map{|m| m.inspected}.sort[-2..].inject(:*)
end

pp day11_1
pp day11_2
