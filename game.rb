require_relative 'player.rb'
require_relative 'deck.rb'
require_relative 'card.rb'
class Game
def initialize(player_names)
  #プレイヤーの作成
  @players  = player_names.map{|name| Player.new(name)}
  #デッキの作成、シャッフル、配る
  @deck = Deck.new
  @deck.shuffle
  @deck.deal(@players)
end
  def game_start
    puts "ゲームスタート！"
    puts "カードが配られました！"
    puts "戦争!"
    until game_over?
      play_round
    end
    show_result
  end

  def play_round
    #各プレイヤーがカードを一枚出す
    table = @players.map{|player|[player,player.draw]}
    #一番強い値のカードを探す
    max_value = table.map{|_,card| card.value}.max
    #一番強いカードを持つプレイヤーを探す
    winners = table.select{|_,card| card.value == max_value}

    if winners.size == 1
      winner = winners.first[0]
      puts "#{winner.name}の勝利！"
      #場にあるカードを取得
      winner.receive(table.map {|_,card| card})
    else
      puts "引き分け！"
      #後で書く
    end
  end

  def game_over?
  alive_players = @players.reject { |player| player.hand.empty? }
  alive_players.size <= 1
  end

  def show_result
    #一番カード持ってた人を表示する(勝者)
    result = @players.sort_by{|player| -player.hand.size}
    puts "ゲーム終了"
    result.each_with_index do |player, i|
      puts "#{i+1}位: #{player.name} (#{player.hand.size}枚)"
    end
  end
end
