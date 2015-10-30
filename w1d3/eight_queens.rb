class Game
end

class Queen
end

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8){Array.new(8)}
    @positions = Set.new
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def place_queen(pos)
    if valid?(pos)
      self[pos] == :queen
    else
      raise "Invalid position"
    end
  end

  def over?
    return false if @positions.length < 8
    @positions.each do |queen1|
      @positions.each do |queen2|
        return false if killable?(queen1, queen2)
      end
    end
    true
  end

  def killable?(queen1, queen2)
    x1, y1 = queen1
    x2, y2 = queen2

    return true if x1 == x2
    return true if y1 == y2
    killable_diagonally?(x1, y1, x2, y2)
  end

  def killable_diagonally?(x1, y1, x2, y2)

  end
end
