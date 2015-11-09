require 'rspec'
require 'card'
require 'stack'

describe Stack do
  describe '#take_card' do
    it "throws an error when called on an empty stack" do
      expect do
        s = Stack.new([])
        s.take_card
      end.to raise_error
    end

    it "returns the top(last) card in the stack" do
      eight_of_clubs = Card.new(:clubs, :eight)
      ten_of_hearts = Card.new(:hearts, :ten)
      s = Stack.new([eight_of_clubs, ten_of_hearts])
      expect(s.take_card).to eq(ten_of_hearts)
      expect(s.take_card).to eq(eight_of_clubs)
    end
  end

  describe "#empty?" do
    it "detects when the stack is empty" do
      expect(Stack.new([])).to be_empty
    end

    it "detects when the stack is NOT empty" do
      s = Stack.new([Card.new(:clubs, :eight)])
      expect(s).to_not be_empty
    end

    it "taking the last card causes the deck to become empty" do
      s = Stack.new([Card.new(:clubs, :eight)])
      expect(s).to_not be_empty
      s.take_card
      expect(s).to be_empty
    end
  end

  describe "#add_cards" do
    let(:stack) { Stack.new([]) }
    let(:cards) { [Card.new(:spades, :deuce), Card.new(:hearts, :ace)] }

    it "adds new cards to the bottom(beginning) of the stack" do
      stack.add_cards([Card.new(:clubs, :jack)])
      expect(stack.take_card).to eq(Card.new(:clubs, :jack))
    end

    it "adds cards in correct order" do
      stack.add_cards(cards)
      expect(stack.take_card).to eq(cards.last)
      expect(stack.take_card).to eq(cards.first)
    end
  end
end
