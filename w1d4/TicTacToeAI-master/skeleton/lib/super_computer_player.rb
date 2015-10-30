require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    # possible_nodes = []
    losing_nodes = []
    game_node = TicTacToeNode.new(game.board, mark)
    game_node.children.each do |child|
      #p game_node.children
      return child.prev_move_pos if child.winning_node?(mark)
      losing_nodes << child if child.losing_node?(mark)
    end
    possible_nodes = game_node.children - losing_nodes
    #raise "No non-losing nodes. Game over." if possible_nodes.empty?
    possible_nodes.sample.prev_move_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
