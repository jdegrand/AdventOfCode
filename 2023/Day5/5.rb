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

def day5_2
    almanac_hash = {}
    seeds = Set.new($lines[0].scan(/\d+/).map(&:to_i))
    seed_ranges = Set.new($lines[0].scan(/\d+/).map(&:to_i))
    sections = %w(seed-to-soil soil-to-fertilizer fertilizer-to-water water-to-light light-to-temperature temperature-to-humidity humidity-to-location)
    reversed_sections = sections.reverse
    $lines[1..].each do |section|
        mapping_hash = Hash.new{|hash, key| hash[key] = key}
        mapping = section.split("\n")[0].split[0]
        dest, source = mapping.split("-to-")
        section.split("\n")[1..].each do |nums|
            dest_start, source_start, range = nums.scan(/\d+/).map(&:to_i)
            mapping_hash[[source_start, source_start + range - 1]] = [dest_start, dest_start + range - 1]
        end
        almanac_hash[mapping] = mapping_hash.sort_by { |key| key }.to_h
    end

    all_ranges = seed_ranges.each_slice(2).map{|seed_start, seed_range| (seed_start...(seed_start + seed_range))}

    _, max_location = almanac_hash[sections[-1]].values.min_by{|start, _| start}
    flipped_almanac = almanac_hash.clone
    sections.each do |s|
        new_subsection = {}
        almanac_hash[s].each{|k, v| new_subsection[v] = k}
        flipped_almanac[s] = new_subsection.sort_by { |key| key }.to_h
    end
    loc = 0
    while true
        seed = loc
        reversed_sections.each do |sec|
            ds = nil
            ss = nil
            flipped_almanac[sec].each do |dest, source|
                break if dest[0] > seed && dest[1] > seed
                if dest[0] <= seed && seed <= dest[1]
                    ds = dest[0]
                    ss = source[0]
                end
            end
            if ss
                seed = seed + (ss - ds)
            end
        end
        return loc if all_ranges.any?{ _1.cover?(seed) }
        loc += 1
    end
end

pp day5_1
pp day5_2
