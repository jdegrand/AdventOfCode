class Day2
    @@file = "input.txt"
    @@input = File.read(@@file)

    @nums = @@input

    def day2_1
        @nums.split("\n").map{|test| 1}
    end

    def day2_2

    end
end

pp Day2.day2_1
pp Day2.day2_2