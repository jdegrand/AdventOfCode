require 'set'
require 'benchmark'


file = 'input.txt'
input = File.read(file)

$lines = input.split("\n\n").map(&:chomp)

def day5_1
    almanac_hash = {}
    seeds = Set.new($lines[0].scan(/\d+/).map(&:to_i))
    sections = %w(seed-to-soil soil-to-fertilizer fertilizer-to-water water-to-light light-to-temperature temperature-to-humidity humidity-to-location)
    $lines[1..].each do |section|
        mapping_hash = Hash.new{|hash, key| hash[key] = key}
        mapping = section.split("\n")[0].split[0]
        dest, source = mapping.split("-to-")
        section.split("\n")[1..].each do |nums|
            dest_start, source_start, range = nums.scan(/\d+/).map(&:to_i)
            mapping_hash[(source_start...(source_start + range))] = [dest_start, range]
        end
        almanac_hash[mapping] = mapping_hash
    end
    seeds.map do |seed|
        sections.each do |sec|
            k, (dest_start, range) = almanac_hash[sec].find{|k, (dest_start, range)| k.cover?(seed)}
            if k
                seed = seed - k.first + dest_start
            end
        end
        seed
    end.min
end

def day5_3
    almanac_hash = {}
    seeds = Set.new($lines[0].scan(/\d+/).map(&:to_i))
    seed_ranges = Set.new($lines[0].scan(/\d+/).map(&:to_i))
    sections = %w(seed-to-soil soil-to-fertilizer fertilizer-to-water water-to-light light-to-temperature temperature-to-humidity humidity-to-location)
    $lines[1..].each do |section|
        mapping_hash = Hash.new{|hash, key| hash[key] = key}
        mapping = section.split("\n")[0].split[0]
        dest, source = mapping.split("-to-")
        section.split("\n")[1..].each do |nums|
            dest_start, source_start, range = nums.scan(/\d+/).map(&:to_i)
            mapping_hash[[source_start, source_start + range - 1]] = dest_start
        end
        almanac_hash[mapping] = mapping_hash.sort_by { |key| key }.to_h
    end
    # seeds.map do |seed|
    #     sections.each do |sec|
    #         k, (dest_start, range) = almanac_hash[sec].find{|(source_start, source_end), (dest_start, range)| source_start <= seed && seed <= source_end}
    #         if k
    #             seed = seed - k.first + dest_start
    #         end
    #     end
    #     seed
    # end.min
    pp almanac_hash
    min_loc = Float::INFINITY

    seed_ranges.each_slice(2).map do |seed_start, seed_range|
        curr_seed = seed_start
        while curr_seed < (seed_start + seed_range)
            seed = curr_seed
            sections.each do |sec|
                ss = nil
                ds = nil
                # pp almanac_hash[sec]
                # puts
                almanac_hash[sec].each do |source, dest_start|
                    break if source[0] > seed && source[1] > seed
                    if source[0] <= seed && seed <= source[1]
                        ss = source[0]
                        ds = dest_start
                    end
                end
                if ss
                    seed = seed - ss + ds
                end
            end
            min_loc = [seed, min_loc].min
            curr_seed += 1
        end
        pp "Through #{seed_start}"
    end
    min_loc
end

# def day5_2
#     almanac_hash = {}
#     seed_ranges = Set.new($lines[0].scan(/\d+/).map(&:to_i))
#     sections = %w(seed-to-soil soil-to-fertilizer fertilizer-to-water water-to-light light-to-temperature temperature-to-humidity humidity-to-location)
#     $lines[1..].each do |section|
#         mapping_hash = Hash.new{|hash, key| hash[key] = key}
#         mapping = section.split("\n")[0].split[0]
#         dest, source = mapping.split("-to-")
#         section.split("\n")[1..].each do |nums|
#             dest_start, source_start, range = nums.scan(/\d+/).map(&:to_i)
#             mapping_hash[(source_start...(source_start + range))] = [dest_start, range]
#         end
#         almanac_hash[mapping] = mapping_hash
#     end
#     seed_count = 0
#     seed_ranges.each_slice(2).map do |seed_start, seed_range|
#         (seed_start...(seed_start + seed_range)).map do |seed|
#             seed_count += 1
#             sections.each do |sec|
#                 k, (dest_start, range) = almanac_hash[sec].find{|k, (dest_start, range)| k.cover?(seed)}
#                 if k
#                     seed = seed - k.first + dest_start
#                 end
#             end
#             seed
#         end.min
#     end.min
# end

def day5_2
    almanac_hash = {}
    seed_ranges = Set.new($lines[0].scan(/\d+/).map(&:to_i))
    sections = %w(seed-to-soil soil-to-fertilizer fertilizer-to-water water-to-light light-to-temperature temperature-to-humidity humidity-to-location)
    $lines[1..].each do |section|
        mapping_hash = Hash.new{|hash, key| hash[key] = key}
        mapping = section.split("\n")[0].split[0]
        dest, source = mapping.split("-to-")
        section.split("\n")[1..].each do |nums|
            dest_start, source_start, range = nums.scan(/\d+/).map(&:to_i)
            mapping_hash[(source_start...(source_start + range))] = [dest_start, range]
        end
        almanac_hash[mapping] = mapping_hash
    end

    all_ranges = seed_ranges.each_slice(2).map{|seed_start, seed_range| (seed_start...(seed_start + seed_range))}
    min_loc = Float::INFINITY
    # 4020916802
    time2 = Benchmark.measure {
    # 108.87645899970084
    
    seed_ranges.each_slice(2).map do |seed_start, seed_range|
        curr_seed = seed_start
        while curr_seed < (seed_start + seed_range)
            seed = curr_seed
            sections.each do |sec|
                # pp sec
                k, (dest_start, range) = almanac_hash[sec].find{|k, (dest_start, range)| k.cover?(seed)}
                if k
                    seed = seed - k.first + dest_start
                end
            end
            min_loc = [seed, min_loc].min
            curr_seed += 1
        end
        pp "Through #{seed_start}"
    end
}
            
    pp time2.real
    min_loc
end



pp day5_1
pp day5_3
