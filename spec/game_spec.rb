require "player.rb"
require "card.rb"
require "game.rb"


describe Game do

  before :each do
    @game = Game.new("Jim", "Joe")
    @game.player1.coins_available = 5
    @game.player1.buys_available = 1
  end

  it "has cards" do
    expect(@game.coppers.count).to eq(50)
    expect(@game.silvers.count).to eq(40)
    expect(@game.golds.count).to eq(30)
    expect(@game.estates.count).to eq(8)
    expect(@game.dutchys.count).to eq(8)
    expect(@game.provinces.count).to eq(8)
  end

  it "subtracts a card if a player buys it" do
    @game.player1.buy_card(@game.silvers.pop)
    expect(@game.silvers.count).to eq(39)
  end

  it "starts a game" do
  game = Game.new('pam', 'jan')
  game.start_game
  game.players.each do |player|
    expect(player.hand.count).to eq(5)
    expect(player.deck.count).to eq(5)
    expect(player.buys_available).to eq(1)
    expect(player.coins_available).to eq(0)
    expect(player.actions_available).to eq(1)
  end
  end


  end
