require_relative 'match_memory_card'

class Board
  attr_accessor :board
  attr_reader :deck, :width, :length

  def initialize(width, length)
    raise "Impossible board" if (width * length).odd?
    @width = width
    @length = length
    @board = Array.new(width){ Array.new(length) }
    @deck = make_deck(width * length / 2) + make_deck(width * length / 2)
    populate
  end

  def make_deck(max)
    (1..max).to_a.map { |value| Card.new(value) }
  end

  def populate
    shuffled_pairs = (deck).shuffle
    board.each do |row|
      row.each_index do |y|
        row[y] = shuffled_pairs.pop
      end
    end
  end

  def render
    board.each do |row|
      str = ""
      row.each do |card|
        str << card.to_s
      end
      puts str
    end
  end

  def won?
    board.flatten.none?(&:face_down)
  end

  def reveal(pos)
    if self[pos].face_down
      self[pos].reveal
      self[pos]
    else
      return nil
    end
  end

  def [](pos)
    x, y = pos
    board[x][y]
  end

  def cheat
    board.each do |row|
      str = ""
      row.each do |card|
        print card.value
        print " "
      end
      puts str
    end
  end
end
