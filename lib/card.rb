class Card
  attr_reader :name, :cost, :vp, :gold
  def initialize(name, cost, vp, gold)
    @name = name
    @cost = cost
    @vp = vp
    @gold = gold
  end

end
