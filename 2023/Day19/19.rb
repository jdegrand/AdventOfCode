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

def recursion(workflow, workflows)
    if workflow == ?A
        return 'true'
    elsif workflow == ?R
        return 'false'
    end
    rules = workflows[workflow]
    resolved_rules = rules.map{ |rule|
        var, sign, num, next_workflow = rule.match(/([a-z]+)(>|<)(\d+):([a-zAR]+)/)&.captures || [nil, nil, nil, rule]
        if var && sign && num && next_workflow
            "(" + "#{var}#{sign}#{num}&&" + recursion(next_workflow, workflows) + ")"
        else
            "(" + recursion(next_workflow, workflows) + ")"
        end
    }
    return "#{resolved_rules.join("||")}"
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

# (x<1416&&true)
def parser(str, index, depth, values)
    local_string = ''
    while true
        curr = str[index]
        if curr == "("
            return parser(str, index + 1, depth + 1, values.clone)
            break
        elsif curr == ")"
            return true if local_string == "true"
            return false if local_string == "false"
            var = local_string[0]
            sign = local_string[1]
            num = local_string[2..].to_i

            new_range = sign == ?< ? (1...num) : ((num + 1)..4000)

            temp = values.clone
            temp[var] = intersect_range(temp[var], new_range)
            return temp
            break
        elsif curr == "&"
            return parser(str, index + 2, depth, values)
            break
        elsif curr == "|"
            return parser(str, index + 2, depth, values)
            break
        else
            local_string += curr
            index += 1
        end
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

    str = recursion("in", workflows)
    #  Change to 

    values = {
        ?x => [(1..4000)],
        ?m => [(1..4000)],
        ?a => [(1..4000)],
        ?s => [(1..4000)]
    }

    "(s<1351&&(a<2006&&(x<1416&&true)||((x>2662&&true)||(false)))||(m>2090&&true)||((s<537&&(a>3333&&false)||(false))||(x>2440&&false)||(true)))||((s>2770&&(s>3448&&true)||((m>1548&&true)||(true)))||(m<1801&&(m>838&&true)||((a>1716&&false)||(true)))||(false))"

    # str.gsub!("||(false)", '')
    str = "(x<1416&&true)"
    # intersect_range([4..6, 10..14, 18..21], 2..40)
    parser(str, 0, 0, values)
end

pp day19_1
pp day19_2
