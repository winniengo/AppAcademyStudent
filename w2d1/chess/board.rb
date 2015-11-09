require_relative 'display'
require_relative 'knight'
require_relative 'king'
require_relative 'bishop'
require_relative 'queen'
require_relative 'rook'
require_relative 'pawn'

# class InvalidMoveErros < StandardEror
# end

class Board
  attr_accessor :grid

  def initialize(new_board = true)
    @grid = Array.new(8){ Array.new(8) } # empty board
    populate_grid if new_board
  end

  def move(start_pos, end_pos, color)
    if self[start_pos].nil?
      raise ArgumentError.new "no piece at start position"
    end

    if !self[end_pos].nil? && self[end_pos].color == self[start_pos].color
      raise ArgumentError.new "piece cannot move to end position"
    end

    if self[start_pos].color != color
      raise ArgumentError.new "select piece of your color"
    end

    self[end_pos] = self[start_pos].move(end_pos)
    self[start_pos] = nil
  end

  def move!(start_pos, end_pos) # makes move without checking if valid
    self[end_pos] = self[start_pos]
    self[end_pos].position = end_pos
    self[start_pos] = nil
  end

  def populate_grid
    @grid.each_index do |i|
      pieces = populate_row(i)

      @grid[i].each_index do |j|
        @grid[i][j] = pieces[j]
      end
    end
  end

  def populate_row(row)
    if row == 0
      first_row(row, true)
    elsif row == 7
      first_row(row, false)
    elsif row == 1
      second_row(row, true)
    elsif row == 6
      second_row(row, false)
    else
      []
    end
  end

  def first_row(row, color)
    [
      Rook.new(self, [row, 0], color),
      Knight.new(self, [row, 1], color),
      Bishop.new(self, [row, 2], color),
      Queen.new(self, [row, 3], color),
      King.new(self, [row, 4], color),
      Bishop.new(self, [row, 5], color),
      Knight.new(self, [row, 6], color),
      Rook.new(self, [row, 7], color)
    ]
  end

  def second_row(row, color)
    pawns = []
    8.times do |col|
      pawns << Pawn.new(self, [row, col], color)
    end
    pawns
  end

  def [](position)
    i, j = position
    @grid[i][j]
  end

  def []=(position, value)
    i, j = position
    @grid[i][j] = value
  end

  def on_board?(pos)
    pos[0].between?(0, 7) && pos[1].between?(0, 7)
  end

  def in_check?(color)
    kings_position = find_king(color)
    grid.each do |row|
      row.each do |piece|
        if !piece.nil? && piece.color != color
          return true if piece.moves.include?(kings_position)
        end
      end
    end
    false
  end

  def find_king(color)
    grid.each do |row|
      row.each do |piece|
        if !piece.nil? && piece.color == color && piece.value == :king
          return piece.position
        end
      end
    end
    # grid.flatten
  end

  def checkmate?(color)
    if in_check?(color)
      grid.each do |row|
        row.each do |piece|
          if !piece.nil? && piece.color == color
            return false if !piece.moves.empty? # Change to valid moves
          end
        end
      end
      true
    else
      false
    end
  end

  def won?
    checkmate?(true) || checkmate?(false)
  end

  def dup
    duped_board = Board.new(false)
    grid.each_index do |i|
      grid[i].each_with_index do |piece, j|
        if piece.nil?
          duped_board[[i, j]] = nil
        else
          duped_board[[i, j]] = piece.dup(duped_board)
        end
      end
    end
    duped_board
  end
end

# b = Board.new
# b2 = b.dup
# b2.move([1, 4], [3, 4])
# b2.move([6, 4], [4, 4])
# d2 = Display.new(b2)
# d2.render
#
# result = nil
# until result
#   d2.render
#   result = d2.get_input
# end
#
# puts result

# pawn = b2[[3, 4]]
# p pawn.moves
# b2.move([3,4], [4,4])
#
# d = Display.new(b)
# d.render

# p b.in_check?(false)
# p b.checkmate?(false)
# b.move([0,0], [3,0])
# d = Display.new(b)
# d.render
# begin
#   end_pos = gets.chomp.split(",").map(&:to_i)
#   b.move([0,0], end_pos)
# rescue ArgumentError => e
#   puts e
#   retry
# end

# d1 = Display.new(b)
# d.render
