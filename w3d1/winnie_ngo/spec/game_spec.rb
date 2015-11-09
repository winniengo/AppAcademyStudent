require 'rspec'
require 'card'
require 'stack'
require 'ai_player.rb'
require 'game'

describe Game do
  let(:cards) do
    [
      Card.new(:hearts, :ten),
      Card.new(:spades, :queen),
      Card.new(:clubs, :jack),
      Card.new(:spades, :five)
    ]
  end

  describe '::deal_in_players' do
    it "returns an instance of the Game class" do
      expect(Game.deal_in_players(cards)).to be_instance_of(Game)
    end

    it "creates two instances of AIPlayer" do
      expect(AIPlayer).to receive(:new).twice
      Game.deal_in_players(cards)
    end

    it "deals cards to the players in alternating pattern" do
      expect(AIPlayer).to receive(:new) do |arg|
        expect(arg).to match_array([cards[3], cards[1]])
      end
      expect(AIPlayer).to receive(:new) do |arg|
        expect(arg).to match_array([cards[2], cards[0]])
      end
      Game.deal_in_players(cards.dup)
    end
  end

  describe "#game_over?" do
    let(:game) do
      player1 = double('AIPlayer', :out_of_cards? => true)
      player2 = double('AIPlayer', :out_of_cards? => false)
      Game.new(player1, player2)
    end

    it "detects when game is over because a player is out of cards" do
      player1 = double('AIPlayer', :out_of_cards? => true)
      player2 = double('AIPlayer', :out_of_cards? => false)
      g = Game.new(player1, player2)
      expect(g).to be_game_over
    end

    it "detects when game is not over" do
      player1 = double('AIPlayer', :out_of_cards? => false)
      player2 = double('AIPlayer', :out_of_cards? => false)
      g = Game.new(player1, player2)
      expect(g).to_not be_game_over
    end
  end

  describe "#do_battle" do
    it "gets a card from each player" do
      player1 = AIPlayer.new([Card.new(:spades, :deuce)])
      player2 = AIPlayer.new([Card.new(:hearts, :three)])
      game = Game.new(player1, player2)
      expect(player1).to receive(:take_card).and_call_original
      expect(player2).to receive(:take_card).and_call_original
      game.do_battle
    end

    context 'when there is not a tie' do
      it "gives the involved cards to the correct winner" do
        two_card = Card.new(:spades, :deuce)
        three_card = Card.new(:hearts, :three)
        player1 = AIPlayer.new([two_card])
        player2 = AIPlayer.new([three_card])
        game = Game.new(player1, player2)
        expect(player2).to receive(:give_won_cards).with([two_card, three_card])
        game.do_battle
      end

      it "gives the involved cards to the correct winner(testing other player)" do
        jack_card = Card.new(:spades, :jack)
        three_card = Card.new(:hearts, :three)
        player1 = AIPlayer.new([jack_card])
        player2 = AIPlayer.new([three_card])
        game = Game.new(player1, player2)
        expect(player1).to receive(:give_won_cards).with([jack_card, three_card])
        game.do_battle
      end
    end

    context "when there is a tie" do
      context "double war" do
        let(:player_1) do
          jack_card = Card.new(:hearts, :jack)
          three_card = Card.new(:hearts, :three)
          ten_card = Card.new(:hearts, :ten)
          AIPlayer.new([jack_card, three_card, ten_card])
        end

        let(:player_2) do
          three_card = Card.new(:spades, :three)
          jack_card = Card.new(:spades, :jack)
          ten_card = Card.new(:spades, :ten)
          AIPlayer.new([three_card, jack_card, ten_card])
        end

        let(:double_war_game) do
          Game.new(player_1, player_2)
        end

        it "will award POWs to the proper eventual winner of the battle" do
          expect(player_1).to receive(:take_card).exactly(3).times.and_call_original
          expect(player_2).to receive(:take_card).exactly(3).times.and_call_original
          double_war_game.do_battle
        end

        it "awards all POWs to correct player" do
          cards_to_win = [
            Card.new(:hearts, :jack),
            Card.new(:hearts, :three),
            Card.new(:hearts, :ten),
            Card.new(:spades, :jack),
            Card.new(:spades, :three),
            Card.new(:spades, :ten)
          ]

          expect(player_1).to receive(:give_won_cards) do |arg|
            expect(arg).to be_instance_of(Array)
            expect(arg.length).to eq(6)
            expect(arg).to match_array(cards_to_win)
          end
          double_war_game.do_battle
        end
      end

      context "triple war" do
        let(:player_1) do
          ace_card = Card.new(:hearts, :ace)
          three_card = Card.new(:hearts, :three)
          five_card = Card.new(:hearts, :five)
          jack_card = Card.new(:hearts, :jack)
          ten_card = Card.new(:hearts, :ten)
          AIPlayer.new([ace_card, three_card,five_card, jack_card, ten_card])
        end

        let(:player_2) do
          three_card = Card.new(:spades, :three)
          ace_card = Card.new(:spades, :ace)
          five_card = Card.new(:spades, :five)
          jack_card = Card.new(:spades, :jack)
          ten_card = Card.new(:spades, :ten)
          AIPlayer.new([three_card, ace_card, five_card, jack_card, ten_card])
        end

        let(:triple_war_game) do
          Game.new(player_1, player_2)
        end

        it "will enter triple war if two ties occur" do
          expect(player_1).to receive(:take_card).exactly(5).times.and_call_original
          expect(player_2).to receive(:take_card).exactly(5).times.and_call_original

          triple_war_game.do_battle
        end

        it "will award POWs to the proper eventual winner of the battle" do
          cards_to_win = [
            Card.new(:hearts, :three),
            Card.new(:hearts, :five),
            Card.new(:hearts, :ten),
            Card.new(:hearts, :jack),
            Card.new(:hearts, :ace),
            Card.new(:spades, :three),
            Card.new(:spades, :five),
            Card.new(:spades, :ten),
            Card.new(:spades, :jack),
            Card.new(:spades, :ace),
          ]

          expect(player_1).to receive(:give_won_cards) do |arg|
            expect(arg).to be_instance_of(Array)
            expect(arg.length).to eq(10)
            expect(arg).to match_array(cards_to_win)
          end
          triple_war_game.do_battle
        end
      end
    end
  end

  describe "#play" do
    context "when a player runs out of cards outside of battle" do
      it "doesn't initiate a battle if either player has no cards" do
        player_1 = AIPlayer.new([Card.new(:clubs, :four)])
        player_2 = AIPlayer.new([])
        no_war_game = Game.new(player_1, player_2)
        expect(no_war_game).to_not receive(:do_battle)
        no_war_game.play
      end

      it "if one player runs out of cards, another battle isn't initiated" do
        player_1 = AIPlayer.new([Card.new(:clubs, :four)])
        player_2 = AIPlayer.new([
          Card.new(:clubs, :five),
          Card.new(:spades, :ten)
        ])
        one_battle_game = Game.new(player_1, player_2)
        expect(one_battle_game).to receive(:do_battle).once.and_call_original
        one_battle_game.play
        expect(player_1).to be_out_of_cards
        expect(player_2).to_not be_out_of_cards
      end
    end

    context "when a player runs out of cards DURING a battle" do
      it "if one player runs out of cards, another battle isn't initiated" do
        player_1 = AIPlayer.new([Card.new(:clubs, :four)])
        player_2 = AIPlayer.new([
          Card.new(:clubs, :five),
          Card.new(:spades, :four)
        ])
        end_during_battle_game = Game.new(player_1, player_2)
        expect(end_during_battle_game).to receive(:do_battle).once.and_call_original
        expect { end_during_battle_game.play }.to_not raise_error
      end
    end
  end
end
