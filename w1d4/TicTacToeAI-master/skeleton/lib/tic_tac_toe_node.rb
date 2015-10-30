require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board, @next_mover_mark, @prev_move_pos =
      board, next_mover_mark, prev_move_pos
  end

  def losing_node?(evaluator)
    return @board.winner != evaluator if @board.over?
    debugger
    if evaluator == next_mover_mark # player's turn
      self.children.all? { |child| child.losing_node?(evaluator) }
    end
    # else # opponent's turn
    #   self.children.any? { |child| child.losing_node?(evaluator) } &&
    #     self.children.none? { |child| child.winning_node?(evaluator) }
    # end
  end

  def winning_node?(evaluator)
    return @board.winner == evaluator if @board.over?

    if evaluator == next_mover_mark # player's turn
      self.children.any? { |child| child.winning_node?(evaluator) }
    else # opponent's turn
      self.children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    @board.rows.each_with_index do |row, i|
      row.each_index do |j|
        if @board.empty?([i, j])
          new_board = @board.dup
          new_board[[i, j]] = @next_mover_mark
          new_child = TicTacToeNode.new(new_board, next_symbol, [i, j])
          children << new_child
        end
      end
    end
    children
  end

  def next_symbol
    @next_mover_mark == :x ? :o : :x
  end


end
