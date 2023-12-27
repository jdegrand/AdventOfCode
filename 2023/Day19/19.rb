require 'json'

file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n")

def day19_1
    workflows_array = $lines[0].lines.map(&:chomp)
    workflows = {}
    ratings = $lines[1].lines.map(&:chomp)
    reg = /([a-z]+){(.+)}/
    workflows_array.each { |flow|
        name, rules = flow.match(reg).captures
        workflows[name] = rules.split(?,)
    }

    ratings.map{ |l|
        rating = {}
        l[1...-1].split(?,).each{
            k, v = _1.split(?=)
            rating[k] = v.to_i
        }
        workflow = "in"
        until workflow == ?A || workflow == ?R
            rules = workflows[workflow]
            rules.each_with_index{|rule, i|
                if i == rules.length - 1
                    workflow = rule
                    break
                else
                    left, sign, right, next_workflow = rule.match(/([a-z]+)(>|<)(\d+):([a-zAR]+)/).captures
                    left = rating[left]
                    right = right.to_i
                    if sign == ?>
                        temp = left
                        left = right
                        right = temp
                    end
                    if left < right
                        workflow = next_workflow
                        break
                    end
                end
            }
        end
        [rating, workflow]
    }.filter_map{ _1 if _2 == ?A }.map{ _1.values.sum }.sum    
end

def get_accepted(workflow, workflows, values, accepted)
    if workflow == ?A
        # pp values
        accepted << values.values.map(&:size).inject(:*)
        return
    elsif workflow == ?R
        return 
    end
    rules = workflows[workflow]
    new_values = values.clone
    resolved_rules = rules.map{ |rule|
        local_values = new_values.clone
        var, sign, num, next_workflow = rule.match(/([a-z]+)(>|<)(\d+):([a-zAR]+)/)&.captures || [nil, nil, nil, rule]
        if var && sign && num && next_workflow
            num = num.to_i
            current_range = values[var]
            if !current_range.cover?(num)
                # Shouldn't be possible
                local_values[var] = (0...0)
            else
                if sign == ?>
                    local_values[var] = (([num + 1, current_range.min].max)..current_range.max)
                else
                    local_values[var] = (current_range.min..([num - 1, current_range.max].min))
                end
            end
            inverted_range = values[var]
            if !inverted_range.cover?(num)
                # Shouldn't be possible
                new_values[var] = (0...0)
            else
                if sign == ?>
                    new_values[var] = (inverted_range.min..([num, inverted_range.max].min))
                else
                    new_values[var] = (([num, inverted_range.min].max)..inverted_range.max)
                end
            end
            get_accepted(next_workflow, workflows, local_values, accepted)
        else
            get_accepted(next_workflow, workflows, new_values, accepted)
        end
    }
end

def intersect_range(ranges, new_range)
    ranges.delete((1..4000))
    # Falls completely between
    return ranges if ranges.find{ _1.cover?(new_range.min) && _1.cover?(new_range.max) }
    lower_bound = ranges.find_index{ _1.cover?(new_range.min) }
    upper_bound = ranges.find_index{ _1.cover?(new_range.max) }
    
    # Falls between two ranges
    if lower_bound && upper_bound
        return ranges[...lower_bound] + [(ranges[lower_bound].min..ranges[upper_bound].max)].filter{ _1} + (ranges[(upper_bound + 1)..] || [])
    elsif lower_bound
        intersected_range = (ranges[lower_bound].min..new_range.max)
        return ranges[...lower_bound] + [intersected_range] + (ranges[(lower_bound + 1)..] || []).reject{ intersected_range.cover?(_1.max)}
    elsif upper_bound
        intersected_range = (new_range.min..ranges[upper_bound].max)
        return ranges[...upper_bound].reject{ intersected_range.cover?(_1.min)} + [intersected_range] + (ranges[(upper_bound + 1)..] || [])
    else
        new_ranges = []
        ranges.each{|r|
            new_ranges << r if !(new_range.cover?(r.min) && new_range.cover?(r.max))
        }
        # Place in order
        return (new_ranges + [new_range]).sort_by(&:min)
    end
end

def day19_2
    workflows_array = $lines[0].lines.map(&:chomp)
    workflows = {}
    ratings = $lines[1].lines.map(&:chomp)
    reg = /([a-z]+){(.+)}/
    workflows_array.each { |flow|
        name, rules = flow.match(reg).captures
        workflows[name] = rules.split(?,)
    } 

    values = {
        ?x => (1..4000),
        ?m => (1..4000),
        ?a => (1..4000),
        ?s => (1..4000)
    }
    accepted = []

    get_accepted("in", workflows, values, accepted)
    accepted.sum
    # Mine
    # 236866944613058

    # Correct
    # 127675188176682
end

pp day19_1
pp day19_2
