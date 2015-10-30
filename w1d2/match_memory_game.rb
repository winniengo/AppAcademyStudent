require_relative 'match_memory_board'

class Game
  attr_accessor :board, :previous_card, :guessed_pos

  def initialize(width, length)
    @board = Board.new(width, length)
    @previous_card = nil # instance of Card
    @guessed_pos # position on board
  end

  def play
    while !board.won?
      system("clear")
      2.times {
        render
        x, y = prompt
        until valid_pos?(x, y) && valid_card?(x, y)
          puts "Invalid position"
          x, y = prompt
        end
        self.guessed_pos = [x, y]
        make_guess
      }
      sleep(2)
    end
    puts "You win!"
  end

  def make_guess
    if self.previous_card
      second_guess
    else
      first_guess
    end
  end

  def second_guess
    puts "2nd guess"
    current_card = board.reveal(guessed_pos)
    if !(current_card == previous_card)
      self.previous_card.hide
      self.current_card.hide
      puts "No match"
    else
      puts "Successful match"
    end
    self.previous_card = nil
  end

  def first_guess
    puts "1st guess"
    self.previous_card = board.reveal(guessed_pos)
  end

  def render
    board.render
  end

  def prompt
    puts "Please enter row:"
    x = gets.chomp.to_i
    puts "Please enter column:"
    y = gets.chomp.to_i
    [x, y]
  end

  def valid_pos?(x, y)
    (0...board.width).include?(x) && (0...board.length).include?(y)
  end

  def valid_card?(x, y)
    pos = x, y
    board[pos].face_down
  end
end

g = Game.new(2, 3)
g.board.cheat
g.play
