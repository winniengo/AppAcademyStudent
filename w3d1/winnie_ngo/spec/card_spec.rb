require 'card.rb'
require 'rspec'

describe Card do
  describe "::all_cards" do
    it "returns an array of length 52" do
      expect(Card.all_cards).to be_instance_of(Array)
      expect(Card.all_cards.length).to eq(52)
    end

    it "contains all the cards" do
      cards = Card.all_cards
      Card.suits.each do |suit|
        Card.values.each do |val|
          expect(cards.include?(Card.new(suit, val))).to eq(true)
        end
      end
    end
  end

  describe '#initialize' do
    it "detects bad initialization arguments" do
      expect { Card.new(nil, nil) }.to raise_error
      expect { Card.new(:fake_suit, :three) }.to raise_error
      expect { Card.new(:clubs, :shfifteen_teen) }.to raise_error
    end

    it "creates a card with good input" do
      Card.suits do |suit|
        Card.values do |value|
          card = Card.new(suit, value)

          expect(card).to be_instance_of(Card)
          expect(card.suit).to eq(suit)
          expect(card.value).to eq(value)
        end
      end
    end
  end

  describe '#rank' do
    let(:test_card) { Card.new(:spades, :jack) }

    it "returns the correct values" do
      ranks = (2..14).to_a
      values = Card::VALUE_STRINGS.keys

      12.times do |idx|
        card = Card.new(:diamonds, values[idx])
        expect(card.rank).to eq(ranks[idx])
      end
    end
  end

  describe '#<=>' do
    let(:eight_card) { Card.new(:clubs, :eight) }
    let(:other_eight_card) { Card.new(:spades, :eight) }
    let(:four_card) { Card.new(:clubs, :four) }
    let(:ace_card) { Card.new(:clubs, :ace) }

    it "properly detects cards of lesser rank" do
      expect(eight_card <=> four_card).to eq(1)
    end

    it "properly detects cards of greater rank" do
      expect(eight_card <=> ace_card).to eq(-1)
    end

    it "properly detects cards of equal rank" do
      expect(eight_card <=> other_eight_card).to eq(0)
    end
  end
end
