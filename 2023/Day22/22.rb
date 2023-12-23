require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def intersect(r1, r2)
    r1.cover?(r2.begin) || r1.cover?(r2.end) || r2.cover?(r1.begin) || r2.cover?(r1.end)
end

def day22_1
    grid = Hash.new(?.)
    zs = Hash.new([])
    bricks = []
    $lines.each_with_index{ |l, i|
        brick_ends = l.split(?~)
        brick_start, brick_end = brick_ends.map{ _1.split(?,).map(&:to_i) }
        brick_start, brick_end = brick_start.zip(brick_end).map{ [_1, _2].sort }.transpose
        brick = brick_start.zip(brick_end).map{ (_1.._2) }
        bricks << brick
        brick.last.each{ |z| zs[z] += [brick] }
    }

    bricks.sort_by!{ _1.last.begin }

    until bricks.empty?
        brick = bricks.shift
        while true
            bottom_z = brick.last.begin
            break if bottom_z == 1
            new_z_range = (brick.last.begin - 1)..((brick.last.end - 1))
            pending_brick = brick.clone
            pending_brick[2] = new_z_range
            break if zs[bottom_z - 1].any?{|subbrick| pending_brick.zip(subbrick).map{ intersect(_1, _2) }.all? }
            brick.last.each{|zr| zs[zr].delete(brick) }
            pending_brick[2].each{|zr| zs[zr] += [pending_brick] }
            brick = pending_brick
        end
    end

    safe_bricks = Set.new
    zs.each{ |z, bricks|
        bricks.each{ |brick|
            # Skip if isn't top of current brick
            next if brick.last.end != z

            new_z_range = ((brick.last.begin + 1)..(brick.last.end + 1))
            pending_brick = brick.clone
            pending_brick[2] = new_z_range

            its_supporting = zs[z + 1].filter{|subbrick| pending_brick.zip(subbrick).map{ intersect(_1, _2) }.all? }

            # Brick doesn't overlap with anything above it
            if its_supporting.empty?
                safe_bricks << brick
            else
                # Brick overlaps with one above, but there is another brick that supports is
                if its_supporting.all?{ |supported_brick|
                        new_support_z_range = (supported_brick.last.begin - 1)..((supported_brick.last.end - 1))
                        pending_support_brick = supported_brick.clone
                        pending_support_brick[2] = new_support_z_range
                        # Don't include the brick to be removed or the subbrick itself
                        zs[z].reject{ _1 == brick || _1 == supported_brick}.any?{|subbrick|  pending_support_brick.zip(subbrick).map{ intersect(_1, _2) }.all? }
                    }
                    safe_bricks << brick
                end
            end
        }
    }
    safe_bricks.size
end

def day22_2
    grid = Hash.new(?.)
    zs = Hash.new([])
    bricks = []
    $lines.each_with_index{ |l, i|
        brick_ends = l.split(?~)
        brick_start, brick_end = brick_ends.map{ _1.split(?,).map(&:to_i) }
        brick_start, brick_end = brick_start.zip(brick_end).map{ [_1, _2].sort }.transpose
        brick = brick_start.zip(brick_end).map{ (_1.._2) }
        bricks << brick
        brick.last.each{ |z| zs[z] += [brick] }
    }

    bricks.sort_by!{ _1.last.begin }

    bricks_final = []

    until bricks.empty?
        brick = bricks.shift
        while true
            bottom_z = brick.last.begin
            break if bottom_z == 1
            new_z_range = (brick.last.begin - 1)..((brick.last.end - 1))
            pending_brick = brick.clone
            pending_brick[2] = new_z_range
            break if zs[bottom_z - 1].any?{|subbrick| pending_brick.zip(subbrick).map{ intersect(_1, _2) }.all? }
            brick.last.each{|zr| zs[zr].delete(brick) }
            pending_brick[2].each{|zr| zs[zr] += [pending_brick] }
            brick = pending_brick
        end
        bricks_final << brick
    end

    og_zs = zs

    bricks_final.map { |brick_to_remove|
        bricks_moved = 0
        bricks = bricks_final.clone
        bricks.delete(brick_to_remove)
        zs = {}
        og_zs.each{|k, v| zs[k] = v.clone}
        zs.each{ |_, v| v.delete(brick_to_remove) }

        brick = 0
        until bricks.empty?
            brick = bricks.shift
            bottom_z = brick.last.begin
            new_z_range = (brick.last.begin - 1)..((brick.last.end - 1))
            pending_brick = brick.clone
            pending_brick[2] = new_z_range

            unless (bottom_z == 1 || zs[bottom_z - 1].any?{|subbrick| pending_brick.zip(subbrick).map{ intersect(_1, _2) }.all? })
                brick.last.each{|zr| zs[zr].delete(brick) }
                bricks_moved += 1
            end
        end
        bricks_moved
    }.sum
end

pp day22_1
pp day22_2
