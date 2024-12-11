require 'set'
file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day11_1
  stones = $lines[0].split.map(&:to_i)
  25.times {
    new_stones = []
    stones.each{ |stone|
      if (stone == 0)
        new_stones << 1
      elsif ((str = stone.to_s).length % 2 == 0)
        l = str[0...(str.length / 2)].to_i
        r = str[(str.length / 2)..].to_i
        new_stones << l
        new_stones << r
      else
        new_stones << stone * 2024
      end

      stones = new_stones
    }    
  }

  stones.length
end

def day11_2
  stones = [0]
  # 75.times {
  #   new_stones = []
  #   stones.each{ |stone|
  #     if (stone == 0)
  #       new_stones << 1
  #     elsif ((str = stone.to_s).length % 2 == 0)
  #       l = str[0...(str.length / 2)].to_i
  #       r = str[(str.length / 2)..].to_i
  #       new_stones << l
  #       new_stones << r
  #     else
  #       new_stones << stone * 2024
  #     end
  #     stones = new_stones
  #   }
    pp 2024 ** 75

    # pp stones.any?(_1 == 0)
    # pp stones
  # }

  stones.length
  
  # seen = Set.new
  # stones = $lines[0].split.map(&:to_i)
  # 75.times {
  #   seen.merge(Set.new(stones))
  #   new_stones = []
  #   stones.each{ |stone|
  #     if (stone == 0)
  #       new_stones << 1
  #     elsif ((str = stone.to_s).length % 2 == 0)
  #       l = str[0...(str.length / 2)].to_i
  #       r = str[(str.length / 2)..].to_i
  #       new_stones << l
  #       new_stones << r
  #     else
  #       new_stones << stone * 2024
  #     end

  #     stones = new_stones
  #   }
  #   # pp stones.any?(_1 == 0)
  #   # pp stones
  #   pp stones.count{|s| s.to_s.length % 2 == 0}
  #   pp stones.any?{|s| seen.include?(s)}
  #   sleep(1)
  # }

  # stones.length
end

pp day11_1
pp day11_2
