require "set"

file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n").map(&:chomp)

def day5_1
    orderings, pages = $lines.map{ |l| l.split("\n")}
    ohash = Hash.new([])
    orderings.each{ |o| 
        k, v = o.split(?|).map(&:to_i)
        ohash[k] += [v]
    }
    pages.reduce(0) { |v, page|
        int_order = page.split(?,).map(&:to_i)
        int_order[...-1].each_with_index.all?{ |o1, i|
            valid = true
            int_order[(i + 1)..].each { |o2|
                valid = false if ohash[o2].include?(o1)
            }
            valid
        } ? v + int_order[int_order.length / 2] : v
    }
end

def day5_2
    orderings, pages = $lines.map{ |l| l.split("\n")}
    ohash = Hash.new([])
    orderings.each{ |o| 
        k, v = o.split(?|).map(&:to_i)
        ohash[k] += [v]
    }
    pages.map!{ |page| page.split(?,).map(&:to_i) }
    incorrect_pages = pages.reject { |page|
        page[...-1].each_with_index.all?{ |o1, i|
            valid = true
            page[(i + 1)..].each { |o2|
                valid = false if ohash[o2].include?(o1)
            }
            valid
        }
    }
    incorrect_pages.reduce(0) { |v, page| v + page.sort_by{ |o1| page.count{ |o2| ohash[o2].include?(o1) } }[page.length / 2] }
end

pp day5_1
pp day5_2
