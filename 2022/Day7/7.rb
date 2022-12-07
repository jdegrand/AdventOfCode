file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

class EFile
    def initialize(size, name)
        @size = size
        @name = name
    end

    attr_accessor :size
    attr_accessor :name
end

class Directory
    def initialize(name, parent)
        @name = name
        @parent = parent
        @size = nil
        @dir = []
    end

    def directory(name)
        sub_dirs = @dir.filter{|d| d.instance_of?(Directory) && d.name == name}
        if sub_dirs.length == 0
            new_dir = Directory.new(name, self) 
            @dir << new_dir
            return new_dir
        end
        return sub_dirs[0]
    end

    def file(size, name)
        files = @dir.filter{|f| f.instance_of?(EFile) && f.name == name}
        if files.length == 0
            new_file = EFile.new(size.to_i, name)
            @dir << new_file
            return new_file 
        end
        return files[0]
    end

    def calculate_size(dir_sizes)
        if @dir.length == 0
            @size = 0
        else
            @size = @dir.map{|df| df.instance_of?(EFile) ? df.size : df.calculate_size(dir_sizes)}.sum
        end
        dir_sizes << @size
        return size
    end

    attr_accessor :name
    attr_accessor :parent
    attr_accessor :size
end

def day7
    root = Directory.new(?/, nil)
    cd = root
    $lines.each do |l|
        if l.start_with?(?$)
            _, command, val = l.split
            if command == "cd"
                case val
                when "/"
                    cd = root
                when ".."
                    cd = cd.parent
                else
                    cd = cd.directory(val)
                end
            end
        else
            left, right = l.split
            if left == "dir"
                cd.directory(right)
            else
                cd.file(left, right)
            end
        end
    end
    dir_sizes = []
    root_size = root.calculate_size(dir_sizes)
    pp dir_sizes.filter{|size| size <= 100000}.sum
    dir_sizes.sort!
    pp dir_sizes.detect{|size| 70000000 - root_size + size >= 30000000}
end

day7
