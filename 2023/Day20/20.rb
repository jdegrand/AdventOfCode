file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day20_1
    broadcaster = nil
    modules = Hash.new([[], :low, :invalid])
    conj = {}
    $lines.map{ _1.split(" -> ")[0] }.filter{ _1[0] == ?& }.each{ conj[_1[1..]] = [] }
    $lines.each{ |l|
        start, dest =  l.split(" -> ")
        dest = dest.split(", ")
        if start == "broadcaster"
            broadcaster = dest
        elsif start[0] == ?%
            conj.keys.intersection(dest).each{ conj[_1] << start[1..]}
            modules[start[1..]] = [dest, false, :flipflop]
        elsif start[0] == ?&
            conj.keys.intersection(dest).each{ conj[_1] << start[1..]}
            start_hash = {}
            dest.each{|d| start_hash[d] = :low}
            modules[start[1..]] = [dest, start_hash, :conjunction]
        else
            raise "Error reading input..."
        end
    }
    pulses = [:low]
    pulses.each { |pul|
        queue = broadcaster.clone.map{[_1, pul, :broadcaster]}
        until queue.empty?
            name, pulse, called_from = queue.shift
            curr = modules[name]
            pp "#{called_from} -#{pulse}-> #{name}"
            if curr[-1] == :flipflop
                if pulse == :low
                    next_state = !modules[name][1]
                    modules[name][1] = next_state
                    curr[0].each{ |dest| queue << [dest, next_state ? :high : :low, name]}
                end
            elsif curr[-1] == :conjunction
                modules[name][1][called_from] = modules[name][1][called_from] == :low ? :high : :low
                to_send = :high
                if modules[name][1].values.all?(:high)
                    to_send = :low
                end
                curr[0].each{ |dest| queue << [dest, to_send, name]}

            else

                # raise "Invalid module type..."
            end
            # Check conjunctions
            # pp modules
            conj.each{ |k, v|
                # pp "v: #{v}"
                vals = []
                v.each{
                    vals << modules[_1][1]
                }
                # puts
                if vals.all?(true)
                    # pp "here"
                    modules[k][0].each{ |dest| queue << [dest, :low, k]}
                end
            }
            # modules.filter{|-, v| v[-1] == :conjunction}
        end
    }
    # modus
    1
end

def day20_2
end

pp day20_1
pp day20_2
