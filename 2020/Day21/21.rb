require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day21_1
    reg = /\A((?:(?:\w+) )+)\(contains ((?:\w+(?:, )?)+)\)\Z/
    allergens = {}
    counts = Hash.new(0)
    all_ing = Set.new
    $lines.each do |l|
        ingred, aller = l.match(reg).captures
        split_ingred = ingred.chomp.split(" ")
        split_ingred.each{|i| counts[i] += 1}
        ing_set = Set.new(split_ingred)
        all_ing += ing_set
        aller.split(", ").each do |a|
            if !allergens.include?(a)
                allergens[a] = ing_set
            else
                allergens[a] &= ing_set
            end
        end
    end
    possible = Set.new()
    allergens.each{|_, v| possible += v}
    not_possible = all_ing - possible
    not_possible.map{|i| counts[i]}.sum
end

def day21_2
    reg = /\A((?:(?:\w+) )+)\(contains ((?:\w+(?:, )?)+)\)\Z/
    allergens = {}
    counts = Hash.new(0)
    all_ing = Set.new
    $lines.each do |l|
        ingred, aller = l.match(reg).captures
        split_ingred = ingred.chomp.split(" ")
        split_ingred.each{|i| counts[i] += 1}
        ing_set = Set.new(split_ingred)
        all_ing += ing_set
        aller.split(", ").each do |a|
            if !allergens.include?(a)
                allergens[a] = ing_set
            else
                allergens[a] &= ing_set
            end
        end
    end
    possible = Set.new()
    allergens.each{|_, v| possible += v}
    definite = {}
    while allergens.length > 0
        allergens = allergens.sort_by{|_, a| a.length}.to_h
        key, val = allergens.first
        allergens.delete(key)
        definite[key] = val.first
        allergens.each{|k, v| allergens[k] -= val}
    end
    definite.sort_by{|k, _| k}.map{|_, v| v}.join(",")
end

puts day21_1
puts day21_2

