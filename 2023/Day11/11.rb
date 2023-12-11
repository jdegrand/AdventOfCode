require 'set'

file = 'input.txt'
input = File.read(file)

$lines = input.lines.map(&:chomp)

def day11_1
    board = []
    $lines.each { |l|
        if l.chars.all?(?.)
            board << l.chars
            board << (?. * l.length).chars
        else
            board << l.chars
        end
    }
    new_board = []
    board.transpose.each{ |l|
        if l.all?(?.)
            new_board << l
            new_board << (?. * l.length).chars
        else
            new_board << l
        end
    }
    board = Hash.new(?.)
    row_length, col_length = new_board.transpose.length, new_board.transpose[0].length
    new_board.transpose.each_with_index{ |l, r|
        l.each_with_index{ |ch, c|
            board[[r, c]] = ch
        }
    }
    galaxies = board.filter_map{ _1 if _2 == ?# }
    galaxies.combination(2).map { |start, finish|
        start.zip(finish).map{(_1 - _2).abs}.sum
    }.sum
end

def day11_2
    array_board = []
    empty_rows = Set.new
    $lines.each_with_index { |l, r|
        if l.chars.all?(?.)
            empty_rows << r
        end
        array_board << l.chars
    }
    empty_cols = Set.new((0...array_board[0].length).filter_map{|col| col if array_board.map{|l| l[col]}.all?(?.)})
    board = Hash.new(?.)
    row_length, col_length = array_board.length, array_board[0].length
    array_board.each_with_index{ |l, r|
        l.each_with_index{ |ch, c|
            board[[r, c]] = ch
        }
    }
    galaxies = board.filter_map{ _1 if _2 == ?# }
    galaxies.combination(2).map { |start, finish|
        base_length = start.zip(finish).map{(_1 - _2).abs}.sum
        row_start, row_end = [start.first, finish.first].sort
        col_start, col_end = [start.last, finish.last].sort
        extra_cols_length = (col_start..col_end).filter{empty_cols.include?(_1)}.length * (1000000 - 1)
        extra_rows_length = (row_start..row_end).filter{empty_rows.include?(_1)}.length * (1000000 - 1)
        base_length + extra_rows_length + extra_cols_length
    }.sum
end

pp day11_1
pp day11_2
