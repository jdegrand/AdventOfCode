require 'thread'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day18_1
    registers = Hash.new(0)
    instruction = 0
    last_sound = nil
    until instruction >= $lines.size
        op, p1, p2 = $lines[instruction].split
        if !p2
            case op
            when 'snd'
                last_sound = registers[p1]
            when 'rcv'
                return last_sound if registers[p1] != 0
            else
                raise 'Single parameter not matched!'
            end
        else
            p2 = /\A[-+]?\d+\z/.match(p2) ? p2.to_i : registers[p2]
            case op
            when 'set'
                registers[p1] = p2
            when 'add'
                registers[p1] += p2
            when 'mul'
                registers[p1] *= p2
            when 'mod'
                registers[p1] %= p2
            when 'jgz'
                instruction += registers[p1] > 0 ? p2 : 1
                next
            else
                raise 'Double parameters not matched!'
            end
        end
        instruction += 1
    end
end

def threaded_program(id, mutex, recieve_cv, send_cv, recieve_queue, send_queue, send_count)
    registers = Hash.new(0)
    registers[?p] = id
    instruction = 0
    last_sound = nil
    until instruction >= $lines.size
        op, p1, p2 = $lines[instruction].split
        p1_is_int = /\A[-+]?\d+\z/.match(p1)
        if !p2
            case op
            when 'snd'
                mutex.synchronize do
                    send_queue << (p1_is_int ? p1.to_i : registers[p1])
                    send_count << send_count.shift + 1
                    send_cv.signal
                    # puts "Program #{id} sent #{registers[p1]}"
                end

            when 'rcv'
                mutex.synchronize do
                    while recieve_queue.empty?
                        recieve_cv.wait(mutex)
                    end
                    registers[p1] = recieve_queue.shift
                    # puts "Program #{id} recieved #{registers[p1]}"
                end
            else
                raise 'Single parameter not matched!'
            end
        else
            p2 = /\A[-+]?\d+\z/.match(p2) ? p2.to_i : registers[p2]
            case op
            when 'set'
                registers[p1] = p2
            when 'add'
                registers[p1] += p2
            when 'mul'
                registers[p1] *= p2
            when 'mod'
                registers[p1] %= p2
            when 'jgz'
                instruction += (p1_is_int ? p1.to_i : registers[p1]) > 0 ? p2 : 1
                next
            else
                raise 'Double parameters not matched!'
            end
        end
        instruction += 1
    end
end

def day18_2
    mutex = Mutex.new
    program_0_cv = ConditionVariable.new
    program_1_cv = ConditionVariable.new
    program_0_queue = []
    program_1_queue = []
    program_0_send_count = [0]
    program_1_send_count = [0]

    program_0 = Thread.new{threaded_program(0, mutex, program_0_cv, program_1_cv, program_0_queue, program_1_queue, program_0_send_count)}
    program_1 = Thread.new{threaded_program(1, mutex, program_1_cv, program_0_cv, program_1_queue, program_0_queue, program_1_send_count)}

    begin
        program_0.join
        program_1.join
    rescue Exception => e
        puts "Caught error '#{e.class}' (deadlock)!"
    ensure
        return program_1_send_count.shift
    end
    
end

pp day18_1
pp day18_2
