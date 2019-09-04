class Game
  attr_accessor :coppers, :silvers, :golds, :estates, :dutchys, :provinces, :player1, :player2
  def initialize(player_name1, player_name2)
    @player1 = Player.new(player_name1)
    @player2 = Player.new(player_name2)
    @player1.game = self
    @player2.game = self
    @players = [@player1, @player2]
    @coppers = Array.new(50, Card.new("Copper",0,0,1))
    @silvers = Array.new(40, Card.new("Silver",3,0,2))
    @golds = Array.new(30, Card.new("Gold",6,0,3))
    @estates = Array.new(8, Card.new("Estate",2,1,0))
    @dutchys = Array.new(8, Card.new("Dutchy",5,3,0))
    @provinces = Array.new(8, Card.new("Province",8,6,0))
  end

  def start_game
    players.each{|player| player.draw_hand}
  end

  def current_player
    @players[0]
  end
end
