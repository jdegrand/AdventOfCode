class Parser
    attr_accessor :tokens
    def initialize(expression)
        @tokens = tokenize(expression)
        @values = {
            ?x => [(1..4000)],
            ?m => [(1..4000)],
            ?a => [(1..4000)],
            ?s => [(1..4000)]
        }
        @results = []
    end

    def parse
        parse_helper(0, @values)
        return @results
    end

    def parse_helper(index, values)
        curr = @tokens[index]
        return [] if !curr
        # sleep(0.5)
        print curr
        case curr
        when "("
            return parse_helper(index + 1, values.clone)
        when ")"
            return parse_helper(index + 1, values.clone)
        when "||"
            return parse_helper(index + 1, values)
        when "&&"
            return parse_helper(index + 1, values.clone)
        when /true|false/
            @results << [values, curr]
            return parse_helper(index + 1, values.clone)
        when /[xmas]/
            sign = @tokens[index + 1]
            val = @tokens[index + 2].to_i
            new_range = sign == ?> ? ((val + 1)..4000) : new_range = (1...val)
            values[curr] = intersect_range(values[curr], new_range)
            return parse_helper(index + 3, values.clone)
        else
            raise "Invalid token '#{curr}' at position #{index}"
        end
    end
  
    private
  
    def tokenize(expression)
        expression.scan(/\(|\)|&&|\|\||[xmas]|[><]|\d+|true|false/)
    end
  
    def error(message)
        raise "Parse error: #{message}"
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
 end
  
  # Example usage
  
expression = "(s<1351&&(a<2006&&(x<1416&&true)||((x>2662&&true)||(false)))||(m>2090&&true)||((s<537&&(a>3333&&false)||(false))||(x>2440&&false)||(true)))||((s>2770&&(s>3448&&true)||((m>1548&&true)||(true)))||(m<1801&&(m>838&&true)||((a>1716&&false)||(true)))||(false))"
# expression = "(s<1351&&true)"
parser = Parser.new(expression)
pp parser.tokens
result = parser.parse
# result = result.filter_map{ 
#     _1.values.map{|ranges| ranges.map(&:size).sum }.inject(:*) if _2 == "true"
# }
result = result.map{ 
    [_1.values.map{|ranges| ranges.map(&:size).sum }.inject(:*), _2]
}.filter{ _2 == "true"}.map(&:first).sum
pp result
    # pp vals
    # [vals.values.map(&:size).inject(:*), outcome] }
# pp parser.parse.each{ pp _1}

#   parsed_result = parser.parse
  
#   puts "Parsed result:"
#   puts parsed_result
  