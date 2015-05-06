class Game

  @@wins = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  Player = Struct.new(:icon, :moves)

  def initialize
    @player1 = Player.new :X, []
    @player2 = Player.new :O, []
    @player_turn = @player1
    @positions = [1,2,3,4,5,6,7,8,9]
  end

  def play
    loop do
      draw_board
      player_takes_turn
      break if game_over?
      next_player
    end
    play_again?
  end

  private
  def draw_board
    system('clear')
    puts " #{@positions[0]} | #{@positions[1]} | #{@positions[2]}"
    puts "___|___|___"
    puts " #{@positions[3]} | #{@positions[4]} | #{@positions[5]}"
    puts "___|___|___"
    puts " #{@positions[6]} | #{@positions[7]} | #{@positions[8]}"
    puts "   |   |"
    true
  end

  def player_takes_turn
    move = get_player_move
    @positions[move - 1] = @player_turn.icon.to_s
    @player_turn.moves << move
  end

  def get_player_move
    puts "#{@player_turn.icon.to_s}'s turn. Enter the number of the square you want."
    move = gets.chomp.to_i
    unless (1..9).include?(move) && @positions.include?(move)
      puts 'illegal move'
      get_player_move
    end
    move
  end
  
  def game_over?
    if (@@wins.select { |win| (win & @player_turn.moves).length == 3 }).any?
      draw_board
      puts "#{@player_turn.icon.to_s} wins! Congratulations!"
      return true
    elsif (@player1.moves.length + @player2.moves.length) >= 9
      draw_board
      puts "It's a draw"
      return true
    end
    false
  end
  
  def next_player
    @player_turn = (@player_turn == @player1 ? @player2 : @player1)
  end
  
  def play_again?
    puts "Would you like to play again? (y or n)"
    again = gets.chomp.downcase
    case again
    when 'y'
      Game.new.play
    when 'n'
      puts "Thanks for playing!"
      exit
    else
      puts "y or n please"
      play_again?
    end
  end
end

# Game.new