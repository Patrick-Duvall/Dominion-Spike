
require "player.rb"
require "card.rb"

describe Player do
  it "has a deck " do
    player = Player.new('joe')
    expect(player.deck.count).to eq(10)
    expect(player.deck.select{|card|card.name == "Copper" }.count).to eq(7)
    expect(player.deck.select{|card|card.name == "Estate" }.count).to eq(3)
  end
  describe "drawing a hand" do
    it "draws normal hand " do
      player = Player.new('joe')
      player.draw_hand();
      expect(player.deck.count).to eq(5)
      expect(player.hand.count).to eq(5)
    end
    it "draws a hand from deck with less than 5 cards" do
      player = Player.new('joe')
      7.times do
        player.discard << player.deck.pop()
      end
      player.draw_hand();
      expect(player.deck.count).to eq(5)
      expect(player.hand.count).to eq(5)
    end
  end
  it 'discard hand' do
    player = Player.new('joe')
    player.draw_hand();
    player.discard_hand();
    expect(player.deck.count).to eq(5)
    expect(player.hand.count).to eq(0)
    expect(player.discard.count).to eq(5)

  end
  describe "buying cards" do
    it "buy one card " do
      player = Player.new('joe')
      player.coins_available = 4
      player.buys_available = 1
      silver = Card.new("Silver", 3, 0, 2)
      player.buy_card(silver)
      expect(expect(player.discard).to include(silver))
      expect(expect(player.coins_available).to eq(1))
      expect(expect(player.buys_available).to eq(0))
    end
    it "cant buy not enough buys card " do
      player = Player.new('joe')
      player.coins_available = 5
      player.buys_available = 0
      silver = Card.new("Silver", 3, 0, 2)
      expect(player.buy_card(silver)).to eq("Can't buy")
    end
    it "cant buy not enough coins " do
      player = Player.new('joe')
      player.coins_available = 2
      player.buys_available = 1
      silver = Card.new("Silver", 3, 0, 2)
      expect(player.buy_card(silver)).to eq("Can't buy")
    end
  end

  it "shuffles discard back in " do
    player = Player.new('joe')
    player.coins_available = 8
    player.buys_available = 3
    silver = Card.new("Silver", 3, 0, 2)
    player.draw_hand();
    player.draw_hand();
    player.buy_card(silver)
    player.buy_card(silver)
    player.discard_hand();
    player.reshuffle_discard
    expect(player.deck.count).to eq(12)
  end
  it "plays a treasure" do
    player = Player.new('joe')
    player.draw_hand();
    copper = player.hand.find{|card| card.name == "Copper"}
    player.play_card(copper)
    expect(player.hand.count).to eq(4)
    expect(player.in_play.count).to eq(1)
    expect(player.coins_available).to eq(1)
  end

  it "clears play_area" do
    player = Player.new('joe')
    player.draw_hand();
    copper = player.hand.find{|card| card.name == "Copper"}
    player.play_card(copper)
    player.clear_play_area
    expect(player.in_play.count).to eq(0)
    expect(player.discard.count).to eq(1)
  end

  it 'ends turn' do
    player = Player.new('joe')
    player.draw_hand();
    copper = player.hand.find{|card| card.name == "Copper"}
    player.play_card(copper)
    player.coins_available = 4
    player.buys_available = 1
    silver = Card.new("Silver", 3, 0, 2)
    player.buy_card(silver)
    player.end_turn
    expect(player.in_play.count).to eq(0)
    expect(player.discard.count).to eq(6)
    expect(player.hand.count).to eq(5)
    expect(player.deck.count).to eq(0)
  end

  it 'total_score' do
    player = Player.new('joe')
    player.discard << Card.new("Province",8,6,0)
    player.discard << Card.new("Dutchy",5,3,0)

    expect(player.total_score).to eq(12)
  end
end
