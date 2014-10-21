class Game
  
  @@wins = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  
  def initialize
    @X = Player.new :X, []
    @O = Player.new :O, []
    @player_turn = @X
    @arr = [1,2,3,4,5,6,7,8,9]
    @moves = 0
    draw_board
    start
  end
  
  private
  
  def start
    puts "#{@player_turn.icon.to_s}'s turn. Enter the number of the square you want."
    position = gets.chomp
    if (1..9).include?(position.to_i) && @arr.include?(position.to_i)
      move position.to_i
    else
      puts "illegal move"
      start
    end
  end
    
  def next_turn
    @player_turn = (@player_turn == @X ? @O : @X)
    start
  end
  
  def draw_board
    system('clear')
    puts " #{@arr[0]} | #{@arr[1]} | #{@arr[2]}"
    puts "___|___|___"
    puts " #{@arr[3]} | #{@arr[4]} | #{@arr[5]}"
    puts "___|___|___"
    puts " #{@arr[6]} | #{@arr[7]} | #{@arr[8]}"
    puts "   |   |"
  end
  
  def move position
    @arr[position - 1] = @player_turn.icon.to_s
    @player_turn.moves << position
    @moves += 1
    draw_board
    win?
  end
  
  def win?
    @@wins.each { |win| return winner if (win & @player_turn.moves).length >= 3 }
    draw?
  end
  
  def draw?
    if (@X.moves.length + @O.moves.length) < 9
      next_turn
    else
      puts "It's a draw!"
      play_again?
    end
  end
  
  def winner
    puts "#{@player_turn.icon.to_s} wins! Congratulations!"
    play_again?
  end
  
  def play_again?
    puts "Would you like to play again? (y or n)"
    again = gets.chomp.downcase
    case again
    when 'y'
      Game.new.start
    when 'n'
      puts "Thanks for playing!"
      exit
    else
      puts "y or n please"
      play_again?
    end
  end
  
  Player = Struct.new(:icon, :moves)
  
end

Game.new