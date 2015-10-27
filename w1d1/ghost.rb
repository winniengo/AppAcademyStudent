def game_play
  p1 = Player.new
  p2 = Player.new
  g = Game.new(p1, p2)
  while !dictionary.include?(g.fragment)
    keep_playing
end

class Game
  attr_accessor :p1, :p2, :fragment
  attr_reader :dictionary

  def self.my_class

  end

  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
    @fragment = ""
    @dictionary = readin_dictionary
    @current_player = p1
  end

  def readin_dictionary
    dict = Set.new
    file.open('ghost-dictionary.txt').each do |line|
      dict.add(line)
    end
    dict
  end

  # private
  # attr_accessor :fragement
end

# Game.my_class
# game = Game.new
