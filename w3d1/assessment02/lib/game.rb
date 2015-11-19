class Game
  # deal players cards in an alternating pattern
  # return instance of Game
  def self.deal_in_players(deck)
    cards1 = []
    cards2 = []
    until deck.empty?
      cards1 << deck.pop
      cards2 << deck.pop
    end

    Game.new(AIPlayer.new(cards1), AIPlayer.new(cards2))
  end

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  # call do_battle until game is over
  def play
    until game_over?
      do_battle
    end
  end

  # 1. Players each take their top card and lay it face UP.
  # 2. If the cards' rank is the same i.e. 3 of clubs and 3 of hearts,
  #    players take ANOTHER card and lay it face DOWN, then repeat step 1.
  # 3. If the last drawn cards are different ranks, all the cards drawn in
  #    this round are awarded to the drawer of the higher ranked card. 
  def do_battle(prisoners = [])
    begin
      card1 = @player1.take_card
      card2 = @player2.take_card

      case card1 <=> card2
      when 1
        @player1.give_won_cards([card1, card2] + prisoners)
      when 0
        do_battle([@player1.take_card, @player2.take_card, card1, card2] + prisoners)
      when -1
        @player2.give_won_cards([card1, card2] + prisoners)
      end
    rescue OutOfCardsError => e
    end
  end

  # if either of the players has run out of cards, the game is over
  def game_over?
    @player1.out_of_cards? || @player2.out_of_cards?
  end
end
