class Player
  attr_accessor :name,:hand
  def initialize(name)
    @name = name
    @hand = [] #手札(最初は0なので空の配列を作成する)
  end
def draw
   @hand.shift
end



  def receive(card)
    #引いたカードを手札に加える
    @hand.concat(card)
  end

  def hand_empty?
    #手札が空かどうかを確認する
    @hand.empty?
  end

end
