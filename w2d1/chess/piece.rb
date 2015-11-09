class Piece
  attr_accessor :position, :board
  def initialize(board, position)
    @board = board
    @position = position
  end

  def move(new_pos)
    raise "Invalid move" unless self.valid_moves.include?(new_pos)
    @position = new_pos
    self
  end

  def to_s
  end

  def nil?
    @value.nil?
  end

  def on_board?(pos)
    pos[0].between?(0, 7) && pos[1].between?(0, 7)
  end

  def move_into_check?(new_pos)
    duped_board = board.dup
    puts "move into check"
    duped_board.move!(position, new_pos)
    duped_board.in_check?(color)
  end

  def valid_moves
    puts "valid moves"
    all_moves = self.moves
    all_moves.reject { |move| move_into_check?(move)}
  end


  def moves
    # implement by subclasses
  end
end
