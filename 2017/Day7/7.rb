require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day7_1
    reg = /([a-z]+) \(([0-9]+)\)(?: -> ((?:[a-z]+(?:, )?)+))?/
    keys = Set.new
    values = Set.new
    $lines.each do |l|
        root, _, children = l.match(reg).captures
        keys << root
        values.merge(Set.new(children.split(", "))) if children
    end
    (keys - values).to_a[0]
end

def day7_2_rec(root, tree, weights)
    local_weights = []
    tree[root].each do |c|
        done, local_weight = day7_2_rec(c, tree, weights)
        return [done, local_weight] if done
        local_weights << [local_weight, c]
    end

    if local_weights.length != 0 && local_weights.map{|c| c[0]}.uniq.size != 1
        weight_counts = local_weights.map{|c| c[0]}.tally
        mismatch_weight = weight_counts.detect{|_, v| v == 1}[0]
        target_weight = weight_counts.detect{|_, v| v != 1}[0]
        wrong_root = local_weights.detect{|weight, _| weight == mismatch_weight}[1]
        return [true, target_weight - (mismatch_weight - weights[wrong_root])]
    end

    return [false, weights[root] + local_weights.sum{|c| c[0]}]
end

def day7_2
    reg = /([a-z]+) \(([0-9]+)\)(?: -> ((?:[a-z]+(?:, )?)+))?/
    tree = {}
    weights = {}
    $lines.each do |l|
        root, weight, children = l.match(reg).captures
        tree[root] = children ? Set.new(children.split(", ")) : Set.new
        weights[root] = weight.to_i
    end

    tree.freeze
    weights.freeze

    day7_2_rec(day7_1(), tree, weights)[1]
end

pp day7_1
pp day7_2
