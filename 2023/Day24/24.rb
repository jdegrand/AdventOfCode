file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day24_1
    hail = $lines.map{ |l|
        position, velocity = l.split(" @ ").map{ _1.split(?,).map(&:to_i) }
    }

    eqs = hail.map{ |ps, vs|
        px, py, _ = ps
        vx, vy, _ = vs
        m = vy.to_f / vx
        b = py - (m * px)
        [py, m, px, b, vx, vy]
    }

    test_area = (200000000000000..400000000000000)

    eqs.combination(2).count{ |h1, h2|
        y1, m1, x1, b1, vx1, vy1 = h1
        y2, m2, x2, b2, vx2, vy2 = h2
        x = (b2 - b1).to_f / (m1 - m2)
        y = m1 * x + b1

        in_past = [h1, h2].any?{ |h|
            vx, px, vy, py = h[4], h[2], h[5], h[0]
            !(vx.negative? ? (x <= px) : (x >= px))
        }

        !in_past && test_area.cover?(x) && test_area.cover?(y)
    }
end

def day24_2
end

pp day24_1
pp day24_2
