require 'colorize'
require_relative 'cursorable'

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor = [0, 0]
    @selected = nil
  end

  def build_board
    @board.grid.map.with_index do |row, i|
      row.map.with_index do |piece, j|
        color_options = colors_for(i, j)
        if piece.nil?
          "   ".colorize(color_options)
        else
          piece.to_s.colorize(color_options)
        end
      end
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :blue
    end
    { background: bg, color: :white }
  end

  def render(player)
    system("clear")
    puts "Player #{player}'s turn"
    # puts "Fill the grid!"
    # puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_board.each { |row| puts row.join }
  end
end
