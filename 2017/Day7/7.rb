require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day7_1
    reg = /([a-z]+) \(([0-9]+)\)(?: -> ((?:[a-z]+(?:, )?)+))?/

    tree = {}

    keys = Set.new
    values = Set.new

    $lines.each do |l|
        root, weight, children = l.match(reg).captures
        keys << root

        values.merge(Set.new(children.split(", "))) if children
    end
    (keys - values).to_a[0]
end

def day7_2
    reg = /([a-z]+) \(([0-9]+)\)(?: -> ((?:[a-z]+(?:, )?)+))?/

    tree = {}

    keys = Set.new
    values = Set.new

    $lines.each do |l|
        root, weight, children = l.match(reg).captures
        tree[root] = children ? Set.new(children.split(", ")) : Set.new
    end
    tree
end

pp day7_1
# pp day7_2
