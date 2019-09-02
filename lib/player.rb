class Player
  attr_accessor :name, :deck, :discard, :hand, :in_play, :coins_available, :buys_available, :actions_available
  def initialize(name)
    @name = name
    @deck = get_basic_deck()
    @discard = []
    @hand = []
    @in_play = []
    @actions_available = 0
    @coins_available = 0
    @buys_available = 0
  end

  def reshuffle_discard
    until @discard.count == 0
      @deck << @discard.shift
    end
    @deck.shuffle!
  end

  def draw_hand
    5.times do
      reshuffle_discard if @deck.count == 0
      @hand << @deck.shift()
    end
  end

  def discard_hand
    until @hand.count == 0
      @discard << @hand.shift
    end
  end

  def buy_card(card)
    if @coins_available >= card.cost && @buys_available > 0
      @coins_available -= card.cost
      @buys_available -= 1
      @discard << card
    else
      return "Can't buy"
    end
  end

  def play_card(card)
    @coins_available += card.gold
    @in_play << @hand.delete_at(@hand.index(card))
  end

  def clear_play_area
    until @in_play.count == 0
      @discard << @in_play.pop()
    end
  end

  private

  def get_basic_deck
    arr = []
    7.times do
      arr << Card.new("Copper", 0, 0, 1 )
    end
    3.times do
      arr << Card.new("Estate", 2, 1, 0 )
    end
    arr.shuffle!
  end

end
