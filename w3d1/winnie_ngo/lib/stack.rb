class Stack
  def initialize(cards)
    @cards = cards
  end

  # return the top (last) card and remove it from stack
  def take_card
    raise "empty stack" if empty?
    @cards.pop
  end

  # returns true if the stack is empty
  def empty?
    @cards.empty?
  end

  # add cards to the bottom (beginning) of stack
  def add_cards(new_cards)
    @cards = new_cards + @cards
  end
end
