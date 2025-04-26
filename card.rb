class Card
attr_reader :suit, :rank, :value

def initialize(suit,rank)
  @suit = suit
  @rank = rank
  @value  = value_rank(suit,rank)
end

def to_s
  if @suit == "Joker"
    "ジョーカー"
  else
    "#{@suit}#{@rank}"
  end
end

private #内部処理
def value_rank(suit,rank)
  if suit == "Joker"
    return 15 #ジョーカーは最強
  end
  #カードの値を数値に変換する
  case rank
  when "A" then 14
  when "K" then 13
  when "Q" then 12
  when "J" then 11
  else rank.to_i #1～10はそのまま数値
  end
end

end

