file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day20_1
    coords = {}
    coords_reg = /<([-,\d]+)>/
    $lines.each_with_index{|l, i| coords[i] = l.scan(coords_reg).flatten.map{|c| c.split(?,).map(&:to_i)} }
    closest = [nil, 0]
    # Same at 10000
    until closest[1] >= 1000
        coords.each do |pid, (pos, vel, acc)|
            new_vel = vel.zip(acc).map(&:sum)
            new_pos = pos.zip(new_vel).map(&:sum)
            coords[pid][0] = new_pos
            coords[pid][1] = new_vel
        end
        new_closest = coords.keys.min_by{|pid| coords[pid][0].map(&:abs).sum}
        closest = closest[0] == new_closest ? [closest[0], closest[1] + 1] : [new_closest, 0]
    end
    closest[0]
end

def day20_2
    coords = {}
    coords_reg = /<([-,\d]+)>/
    $lines.each_with_index{|l, i| coords[i] = l.scan(coords_reg).flatten.map{|c| c.split(?,).map(&:to_i)} }
    closest = [nil, 0]
    # Same at 10000
    until closest[1] >= 1000
        counts = Hash.new([])
        coords.each do |pid, (pos, vel, acc)|
            new_vel = vel.zip(acc).map(&:sum)
            new_pos = pos.zip(new_vel).map(&:sum)
            coords[pid][0] = new_pos
            coords[pid][1] = new_vel
            counts[new_pos] += [pid]
        end
        coords.filter{|x|}
        counts.values.each{|to_delete| to_delete.each{|pid| coords.delete(pid)} if to_delete.length > 1}
        new_closest = coords.keys.min_by{|pid| coords[pid][0].map(&:abs).sum}
        closest = closest[0] == new_closest ? [closest[0], closest[1] + 1] : [new_closest, 0]
    end
    coords.size
end

pp day20_1
pp day20_2
