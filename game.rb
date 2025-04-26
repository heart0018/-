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
    until game_over?
      play_round
    end
    show_result
  end

  def play_round
    #各プレイヤーがカードを一枚出す
     table = @players.map do |player|
    card = player.draw
    puts "#{player.name} の手札: #{player.hand.size}枚 → 出したカード: #{card.to_s}"
    [player, card]
  end

    #誰かが0枚になったら、ゲーム終了
  empty_players = table.select{|_,card| card.nil?}.map{|player, _| player.name}
  unless empty_players.empty?
    puts "カードが0枚にプレイヤーがいるため、ゲーム終了"
    empty_players.each{|name| puts "#{name}が敗北"}
    show_result
    exit
  end


    #一番強い値のカードを探す
    max_value = table.map{|_,card| card.value}.max
    #一番強いカードを持つプレイヤーを探す
    winners = table.select{|_,card| card.value == max_value}

    #Aが複数枚出た場合スペードのAがある？
    if winners.size >= 2
      spade_a = winners.find{|_,card| card.suit == "♠" && card.rank == "A"}
      if spade_a
        winners = spade_a[0]
        puts "#{winners.name}がスペードA『世界一』で勝利！"
        winners.receive(table.map {|_,card| card}.shuffle)
        return
      end
    end

    if winners.size == 1
      winner = winners.first[0]
      puts "#{winner.name}の勝利！"
      #場にあるカードを取得
      winner.receive(table.map {|_,card| card}.shuffle)
    else
      puts "引き分け！"
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
