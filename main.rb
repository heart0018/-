require_relative "./game.rb"
 puts "戦争を開始します"
  puts "プレイヤーの名前を入力してください(2～5)"
  player_count = gets.chomp.to_i
  until(2..5).include?(player_count)
    puts "2～5の数字を入力してください"
    player_count = gets.chomp.to_i
  end

  player_names = []
  player_count.times do |i|
    puts "#{i + 1}人目の名前を入力してください"
    name = gets.chomp
    player_names << name
  end
  puts "カードが配られました！"
  puts "戦争！"

game = Game.new(player_names)
game.game_start
