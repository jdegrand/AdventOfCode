file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day22_1
    cuboids = Hash.new(false)
    reg = /(on|off) x=(?:(-?\d+)..(-?\d+)),y=(?:(-?\d+)..(-?\d+)),z=(?:(-?\d+)..(-?\d+))/
    $lines[0...20].each do |l|
        on, *coords = l.match(reg).captures
        x0, x1, y0, y1, z0, z1 = coords.map(&:to_i)
        on = on == "on" ? true : false
        (x0..x1).each do |x|
            (y0..y1).each do |y|
                (z0..z1).each do |z|
                    cuboids[[x, y, z]] = on
                end
            end
        end
    end
    cuboids.count{|_, v| v == true}
end

class Cube
    def initialize(x0, x1, y0, y1, z0, z1)
        @x0 = x0
        @x1 = x1 + 1
        @y0 = y0
        @y1 = y1 + 1
        @z0 = z0
        @z1 = z1 + 1
        @volume = (x1 - x0 + 1).abs * (y1 - y0 + 1).abs * (z1 - z0 + 1).abs
    end

    def split(cube)
        return [] if cube.larger(self)
        if (self.x1 > cube.x0) && (self.x0 < cube.x1) && (self.y1 > cube.y0) && (self.y0 < cube.y1) && (self.z1 > cube.z0) && (self.z0 < cube.z1)
            new_cubes = []
            x0_yz, x1_yz = 0, 0
            y0_z, y1_z = 0, 

            if self.x1 >= cube.x1 && self.x0 <= cube.x0
                x0_x, x1_x, x0_yz, x1_yz = [self.x0, cube.x0, cube.x0, cube.x1]
                x0_x2, x1_x2 = [cube.x1, self.x1]
                new_cubes << [x0_x, x1_x, self.y0, self.y1, self.z0, self.z1]
                new_cubes << [x0_x2, x1_x2, self.y0, self.y1, self.z0, self.z1]
            elsif self.x1 <= cube.x1 && self.x0 >= cube.x0
                x0_yz, x1_yz = [self.x0, self.x1]
            else
                left = self.x0 < cube.x0 ? self : cube
                right = self.x0 < cube.x0 ? cube : self
                return [self] if left.x1 < right.x0
                x0_x, x1_x, x0_yz, x1_yz = self.x1 < cube.x1 ? [self.x0, cube.x0, cube.x0, self.x1] : [cube.x1, self.x1, self.x0, cube.x1]
                new_cubes << [x0_x, x1_x, self.y0, self.y1, self.z0, self.z1]
            end

            if self.y1 >= cube.y1 && self.y0 <= cube.y0
                y0_y, y1_y, y0_z, y1_z = [self.y0, cube.y0, cube.y0, cube.y1]
                y0_y2, y1_y2 = [cube.y1, self.y1]
                new_cubes << [x0_yz, x1_yz, y0_y, y1_y, self.z0, self.z1]
                new_cubes << [x0_yz, x1_yz, y0_y2, y1_y2, self.z0, self.z1]
            elsif self.y1 <= cube.y1 && self.y0 >= cube.y0
                y0_z, y1_z = [self.y0, self.y1]
            else
                left = self.y0 < cube.y0 ? self : cube
                right = self.y0 < cube.y0 ? cube : self
                return [self] if left.y1 < right.y0
                y0_y, y1_y, y0_z, y1_z = self.y0 < cube.y0 ? [self.y0, cube.y0, cube.y0, self.y1] : [cube.y1, self.y1, self.y0, cube.y1]
                new_cubes << [x0_yz, x1_yz, y0_y, y1_y, self.z0, self.z1]
            end

            if self.z1 >= cube.z1 && self.z0 <= cube.z0
                z0_z, z1_z = [self.z0, cube.z0]
                z0_z2,z1_z2 = [cube.z1, self.z1]
                new_cubes << [x0_yz, x1_yz, y0_z, y1_z, z0_z, z1_z]
                new_cubes << [x0_yz, x1_yz, y0_z, y1_z, z0_z2, z1_z2]
            elsif self.z1 <= cube.z1 && self.z0 >= cube.z0
                # Nothing depends on this, but we don't want to add any new cubes
            else
                left = self.z0 < cube.z0 ? self : cube
                right = self.z0 < cube.z0 ? cube : self
                return [self] if left.z1 < right.z0
                z0_z, z1_z = self.z1 < cube.z1 ? [self.z0, cube.z0] : [cube.z1, self.z1]
                new_cubes << [x0_yz, x1_yz, y0_z, y1_z, z0_z, z1_z]
            end
            
            return new_cubes.map{|x0, x1, y0, y1, z0, z1| Cube.new(x0, x1 - 1, y0, y1 - 1, z0, z1 - 1)}
        end
        return [self]
    end

    def larger(cube)
        self.x1 >= cube.x1 && self.x0 <= cube.x0 && self.y1 >= cube.y1 && self.y0 <= cube.y0 && self.z1 >= cube.z1 && self.z0 <= cube.z0
    end

    def intersect(cube)
        if (self.x1 > cube.x0) && (self.x0 < cube.x1) && (self.y1 > cube.y0) && (self.y0 < cube.y1) && (self.z1 > cube.z0) && (self.z0 < cube.z1)
            x = self.x1 < cube.x1 ? self.x1 - cube.x0 : cube.x1 - self.x0
            y = self.y1 < cube.y1 ? self.y1 - cube.y0 : cube.y1 - self.y0
            z = self.z1 < cube.z1 ? self.z1 - cube.z0 : cube.z1 - self.z0
            return x * y * z
        else
            return 0
        end
    end

    attr_accessor :x0, :x1, :y0, :y1, :z0, :z1, :volume
end

def day22_2
    cuboids = Hash.new(false)
    reg = /(on|off) x=(?:(-?\d+)..(-?\d+)),y=(?:(-?\d+)..(-?\d+)),z=(?:(-?\d+)..(-?\d+))/
    ons = []
    volume = 0
    $lines.each do |l|
        on, *coords = l.match(reg).captures
        x0, x1, y0, y1, z0, z1 = coords.map(&:to_i)

        on = on == "on" ? true : false

        curr_cube = Cube.new(x0, x1, y0, y1, z0, z1)

        new_ons = []
        ons.each do |cube|
            new_ons << cube.split(curr_cube)
        end
        new_ons.flatten!
        new_ons << curr_cube if on
        ons = new_ons
    end
    ons.map{|cube| cube.volume}.sum
end

pp day22_1
pp day22_2
