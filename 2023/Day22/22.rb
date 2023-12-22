file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

#   1,0,1~1,2,1
#   0,0,2~2,0,2
#   0,2,3~2,2,3
#   0,0,4~0,2,4
#   2,0,5~2,2,5
#   0,1,6~2,1,6
#   1,1,8~1,1,9
def day22_1
    grid = Hash.new(?.)
    zs = Hash.new([])
    bricks = []
    $lines.each_with_index{ |l, i|
        brick_ends = l.split(?~)
        brick_start, brick_end = brick_ends.map{ _1.split(?,).map(&:to_i) }
        brick_start, brick_end = brick_start.zip(brick_end).map{ [_1, _2].sort }.transpose
        new_brick = brick_start.zip(brick_end).map{ (_1.._2) }
        bricks << [new_brick, i]
        new_brick.last.each{ |z| zs[z] += [[new_brick, i]] }

    }

    range_overlap = ->(r1, r2) {
        r2.cover?(r1.begin) || r2.cover?(r1.end) || r1.cover?(r2.begin) || r1.cover?(r2.end)
    }

    bricks.sort_by{ |brick, _| brick.last.begin }

    until bricks.empty?
        brick, label = bricks.shift
        while true
            z = brick.last.begin
            break if z == 1
            old_z_range = brick.last
            new_z_range = ((old_z_range.begin - 1)..(old_z_range.last - 1))
            new_brick = brick.clone
            new_brick[2] = new_z_range
            break if zs[z - 1].any?{|subbrick, _| new_brick.zip(subbrick).map{ range_overlap.call(_1, _2)}.all? }
            old_z_range.each{ zs[_1].delete([brick, label]) }
            new_z_range.each{ zs[_1] += [[new_brick, label]] }
            brick = new_brick
        end
    end

    zs.map{|z, bricks|
        bricks.filter{ |brick, label|
            next false if brick.last.end != z
            new_brick = brick.clone
            new_z_range = ((brick.last.begin + 1)..(brick.last.end + 1))
            new_brick[2] = new_z_range
            its_supporting = zs[z + 1].filter{|subbrick, sublabel| new_brick.zip(subbrick).map{ range_overlap.call(_1, _2)}.all? && label != sublabel }
            its_supporting.map{|supported, suplabel|
                (zs[z].reject{ _1 == [brick, label] || _1 == [supported, suplabel] }).any?{ |subbrick, _|
                    updated_supported = supported.clone
                    updated_supported[2] = brick.last
                    updated_supported.zip(subbrick).map{ range_overlap.call(_1, _2)}.all?
                }
            }.any? || its_supporting.empty?
            # pp "#{label}"
            # pp "brick #{brick}"
            # pp " all zs #{zs[z]}"
            # pp "- curr #{(zs[z].reject{ _1 == [brick, label] })}"
            # pp "its_supporting #{its_supporting}"
            
            # x = its_supporting.map{|supported, _|
            #     (zs[z].reject{ _1 == [brick, label] }).any?{|subbrick, _| supported.zip(subbrick).map{ range_overlap.call(_1, _2)}.all? }
            # }
            # pp x
            # puts
            # return
            # puts
        }.map(&:last)
    }.flatten.uniq.length

    # bricks
    # zs
end

def day22_2
end

pp day22_1
pp day22_2
