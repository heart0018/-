
class Deck
  attr_reader :cards
  def initialize
    @cards = []
    #スートの定義
    @suits = ["♠", "♥", "♦", "♣"]
    #数字の定義
    @ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]

    #スートと数字を組み合わせてカードを作成
    @suits.each do |suit|
      @ranks.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
  end
  def shuffle
    @cards.shuffle!
  end
  def deal(players)
    #１枚ずつ配る
    until @cards.empty?
      players.each do |player|
        card = @cards.shift
        player.hand << card if card
      end
    end
  end

end


