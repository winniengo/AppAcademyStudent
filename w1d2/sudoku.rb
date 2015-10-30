require 'colorize'

class Tile
  attr_accessor :value, :given

  def initialize(value=0, given=false)
    @value = value
    @given = given
  end

  def to_s
    given ? value.to_s.colorize(:blue) : value.to_s.colorize(:red)
  end

  def filled?
    value != 0
  end
end

class Board
  attr_accessor :grid

  def initialize(grid)
    @grid = grid
  end

  def update_tile(pos, value)
    self[pos].value = value
  end

  def render
    grid.each_with_index do |row, x|
      puts "-----------------------" if x % 3 == 0
      str = ""
      row.each_with_index do |tile, y|
        str << "| " if y % 3 == 0 && y != 0
        if tile.filled?
          str << "#{tile.to_s} "
        else
          str << "X "
        end
      end
      puts str
    end
  end

  def solved?
    return false unless grid.flatten.all?(&:filled?)

    grid.all?{ |row| row_solved?(row) } &&
      grid.transpose.all?{ |col| row_solved?(col) } &&
      self.create_mini_grid.all?{ |mg| row_solved?(mg) }
  end

  def row_solved?(row)
    row.map(&:value).uniq.length == 9
  end


  def create_mini_grid
    mgs = Array.new(9) {Array.new}
    grid.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        if x < 3
          create_mini_grid_helper(mgs, tile, y, 0)
        elsif x < 6
          create_mini_grid_helper(mgs, tile, y, 3)
        else
          create_mini_grid_helper(mgs, tile, y, 6)
        end
      end
    end
    mgs
  end

  def create_mini_grid_helper(mgs, tile, y, n)
    if y < 3
      mgs[n] << tile
    elsif y < 6
      mgs[n + 1] << tile
    else
      mgs[n + 2] << tile
    end
  end

  def self.from_file(file_name)
    grid = []
    File.foreach(file_name) do |line|
      grid << line.chomp.split("").map do |el|
        el == "0" ? Tile.new : Tile.new(el.to_i, true)
      end
    end
    grid
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def valid_pos?(pos)
    !self[pos].given
  end

  def transpose
    return grid.transpose
  end
end

class Game
  attr_accessor :board
  def initialize(file_name)
    @board = readfile(file_name)
  end

  def play
    until board.solved?
      board.render
      pos, value = prompt
      board.update_tile(pos, value)
    end
    puts "You win!"
    board.render
  end

  def readfile(file_name)
    Board.new(Board.from_file(file_name))
  end

  def prompt
      begin
        puts "Please enter a row #:"
        x = gets.chomp.to_i
        puts "Please enter a col #"
        y = gets.chomp.to_i
      end until valid_pos?(x, y)

      begin
        puts "Please enter a value:"
        val = gets.chomp.to_i
      end until (1..9).include?(val)

      [[x, y], val]
  end

  def valid_pos?(x, y)
    (0..8).include?(x) && (0..8).include?(y) &&
      board.valid_pos?([x, y])
  end

end

puzzle = Board.from_file('puzzles/sudoku1.txt')
b = Board.new(puzzle)
puts b.solved?

puzzle2 = Board.from_file('puzzles/sudoku1-solved.txt')
b2 = Board.new(puzzle2)
puts b2.solved?

#b3 = Board.new(b.transpose)
#b3.render

#b4 = Board.new(b.create_mini_grid)
#b4.render

g = Game.new('puzzles/sudoku1-almost.txt')
g.play
