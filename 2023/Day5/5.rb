require 'set'

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
    seed_count = 0
    seed_ranges.each_slice(2).map{|seed_start, seed_range| (seed_start...(seed_start + seed_range))}.sort_by(&:min)
    # seed_ranges.each_slice(2).map do |seed_start, seed_range|
    #     (seed_start...(seed_start + seed_range)).map do |seed|
    #         seed_count += 1
    #         sections.each do |sec|
    #             k, (dest_start, range) = almanac_hash[sec].find{|k, (dest_start, range)| k.cover?(seed)}
    #             if k
    #                 seed = seed - k.first + dest_start
    #             end
    #         end
    #         seed
    #     end.min
    # end.min
end

pp day5_1
pp day5_2
