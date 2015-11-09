class AIPlayer
  # keep a stack of cards
  def initialize(cards)
    @stack = Stack.new(cards)
  end

  # return the top card from the stack
  # raise an error if the stack is empty
  def take_card
    raise OutOfCardsError if @stack.empty?
    @stack.take_card
  end

  # add the cards to the bottom of the stack
  def give_won_cards(cards)
    @stack.add_cards(cards)
  end

  # returns true if stack is empty
  def out_of_cards?
    @stack.empty?
  end
end

class OutOfCardsError < StandardError
end
