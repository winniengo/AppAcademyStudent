# -*- coding: utf-8 -*-

# Represents a playing card.
class Card
  SUIT_STRINGS = {
    clubs: '♣',
    diamonds: '♦',
    hearts: '♥',
    spades: '♠'
  }

  VALUE_STRINGS = {
    deuce: '2',
    three: '3',
    four: '4',
    five: '5',
    six: '6',
    seven: '7',
    eight: '8',
    nine: '9',
    ten: '10',
    jack: 'J',
    queen: 'Q',
    king: 'K',
    ace: 'A'
  }

  VALUE_RANK = {
    deuce: 2,
    three: 3,
    four: 4,
    five: 5,
    six: 6,
    seven: 7,
    eight: 8,
    nine: 9,
    ten: 10,
    jack: 11,
    queen: 12,
    king: 13,
    ace: 14
  }

  # Returns an array of all suits.
  def self.suits
    SUIT_STRINGS.keys
  end

  # Returns an array of all values.
  def self.values
    VALUE_STRINGS.keys
  end

  # Returns an array of all 52 cards.
  def self.all_cards
    all_cards = []
    SUIT_STRINGS.keys.each do |suit|
      VALUE_STRINGS.keys.each do |val|
        all_cards << Card.new(suit, val)
      end
    end
    all_cards
  end

  attr_reader :suit, :value

  # Throws an error if suit or value is not valid.
  def initialize(suit, value)
    raise "bad initialization arguments" unless SUIT_STRINGS.include?(suit) && VALUE_STRINGS.include?(value)
    @suit, @value = suit, value
  end

  # Returns an integer value of card's rank. For example:
  # 2 of Clubs rank: 2. Jack of Hearts: 11. Ace of Spades: 14
  def rank
    VALUE_RANK[value]
  end

  # Returns 0 if rank is equal to other, 1 if rank is greater,
  # and -1 if rank is less.
  def <=>(other)
    rank <=> other.rank
  end

  # Compares two cards to see if they're equal in suit & value.
  # DO NOT CHANGE THIS METHOD
  def ==(other)
    other.suit == suit && other.value == value
  end

  def to_s
    VALUE_STRINGS[value] + SUIT_STRINGS[suit]
  end
end
