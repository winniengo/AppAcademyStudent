require 'rspec'
require 'card'
require 'stack'
require 'ai_player'

describe AIPlayer do
  let(:cards) do
    [Card.new(:hearts, :five),
     Card.new(:diamonds, :four),
     Card.new(:hearts, :four)]
  end

  let(:player) { AIPlayer.new(cards.dup) }

  describe '#initialize' do
    it "takes an array of cards to create the player's '@stack' ivar" do
      expect(player).to be_instance_of(AIPlayer)
      expect(player.instance_variable_get(:@stack)).to be_instance_of(Stack)
    end

    it "doesn't expose the stack using accessor methods" do
      expect(player).to_not respond_to(:stack)
      expect(player).to_not respond_to(:stack=)
    end
  end

  describe '#take_card' do
    it "returns the top card on the player's stack" do
      2.downto(0) do |idx|
        expect(player.take_card).to eq(cards[idx])
      end
    end

    it "throws an OutOfCardsError when the stack is empty" do
      expect do
        4.times { player.take_card }
      end.to raise_error(OutOfCardsError)
    end
  end

  let(:empty_player) { AIPlayer.new([]) }

  describe "#give_won_cards" do
    it "puts the cards into the player's stack" do
      expect { empty_player.take_card }.to raise_error
      empty_player.give_won_cards([Card.new(:hearts, :nine)])
      expect { empty_player.take_card }.to_not raise_error
    end

    it "places the cards into the bottom of the player's stack" do
      empty_player.give_won_cards([Card.new(:hearts, :nine)])
      empty_player.give_won_cards([Card.new(:spades, :ace)])
      expect(empty_player.take_card).to eq(Card.new(:hearts, :nine))
    end
  end

  describe "#out_of_cards?" do
    it "returns false when the stack is not empty" do
      expect(player).to_not be_out_of_cards
    end

    it "returns true when the stack is empty" do
      expect(empty_player).to be_out_of_cards
    end
  end
end
