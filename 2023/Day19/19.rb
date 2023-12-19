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
        pp next_workflow
        if var && sign && num && next_workflow
            "(" + "#{var}#{sign}#{num}&&" + recursion(next_workflow, workflows) + ")"
        else
            "(" + recursion(next_workflow, workflows) + ")"
        end
    }
    return "#{resolved_rules.join("||")}"
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

    recursion("in", workflows)
end

pp day19_1
pp day19_2
