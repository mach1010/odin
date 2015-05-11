require "connect4/version"

class Connect4
  attr_accessor :game_state, :player_turn
  Player = Struct.new :icon
  
  def initialize
    @player1 = Player.new 1
    @player2 = Player.new 2
    @player_turn = @player1
    @game_state = [[],[],[],[],[],[],[]]
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
  
  # private
  
  def draw_board
    system('clear')
    puts "  1 2 3 4 5 6 7"
    rows.each do |row|
      row_string = ' |'
      row.each { |cell| row_string << (cell ? cell.to_s + '|' : '_|') }
      puts row_string
    end
    nil
  end
  
  def player_takes_turn
    column = get_player_move - 1
    @game_state[column].push @player_turn.icon.to_s
  end
  
  def get_player_move
    loop do
      puts "Player #{@player_turn.icon}'s turn. Enter a column number"
      input = gets.chomp.to_i
      return input if (1..7).include?(input) && 
        @game_state[(input - 1)].count < 6
      puts 'illegal move'
    end
  end
  
  def next_player
    @player_turn = (@player_turn == @player1 ? @player2 : @player1)
  end
  
  def game_over?
    if tie_game?
      draw_board
      puts "it's a tie"
      return true
  elsif winner?
      draw_board
      puts "Player #{@player_turn.icon} wins!"
      return true
    end
    false
  end
  
  def tie_game?
    @game_state.flatten.count == 42
  end
  
  def winner?
    rows.any? { |row| four_in_a_row row } ||
    @game_state.any? { |column| four_in_a_row column } ||
    diagonals.any? { |diagonal| four_in_a_row diagonal }
  end
  
  def four_in_a_row vector
    return false if vector.length < 4
    count, current, val = 0, 0, nil
    vector.each do |index|
      index == val && !index.nil? ? current += 1 : current = 0
      count = current if count < current
      val = index
    end
    count >= 3
  end
  
  def rows
    rows = []
    (0...6).each do |index|
      rows << @game_state.collect { |col| col[index] }
    end
    rows.reverse
  end
  
  def diagonals
    diagonals = []
    @game_state.each_with_index do |column, col_index|
      column.each_with_index do |row, row_index|
        current   = [col_index, row_index]
        diagonals << diagonal_up(current)
        diagonals << diagonal_down(current) 
      end
    end
    # binding.pry
    diagonals
  end

  def diagonal_up cell
    diagonal = [cell]
    while diagonal.last
      current = diagonal.last
      diagonal << (current[0] < 6 && current[1] < 5 ? 
        [current[0] + 1, current[1] + 1] : nil)
    end
    diagonal.pop
    diagonal.map { |index| @game_state[index[0]][index[1]] }
  end  
 
  def diagonal_down cell
    diagonal = [cell]
    while diagonal.last
      current = diagonal.last
      diagonal << (current[0] < 6 && current[1] > 0 ? 
        [current[0] + 1, current[1] - 1] : nil)
    end
    diagonal.pop
    diagonal.map { |index| @game_state[index[0]][index[1]] }
  end
  
  def play_again?
    puts "Would you like to play again? (y or n)"
    again = gets.chomp.downcase
    case again
    when 'y'
      Connect4.new.play
    when 'n'
      puts "Thanks for playing!"
      exit
    else
      puts "y or n please"
      play_again?
    end
  end
end

 #  1 2 3 4 5 6 7
 # |_|_|_|_|_|_|_|
 # |_|_|_|_|_|_|_|
 # |_|_|_|_|_|_|_|
 # |_|_|_|_|_|_|_|
 # |_|_|1|2|_|_|_|
 # |_|_|2|1|1|2|_|
 #
 # game_state = [[], [], [2,1], [1, 2], [1], [2], []]


 
 
 # bl to tr
 # 00, 11, 22, 33, 44, 55
 # 01, 12, 23, 34, 45
 # 02, 13, 24, 35
 #
 # 10, 21, 32, 43, 54, 65
 # # 11, 22, 33, 44, 55 dup
 # # 12, 23, 34, 45 dup
 #
 # 20, 31, 42, 53, 64
 # # 21, 32, 43, 54, 65 dup
 # # 22, 33, 44, 55 dup
 #
 # 30, 41, 52, 63
 # # 31, 42, 53, 64 dup
 # # 32, 43, 54, 65 dup
 #
 #
 # 03, 12, 21, 30
 # 04, 13, 22, 31, 40
 # 05, 14, 23, 32, 41, 50
 #
 # # 13, 22, 31, 40 dup
 # # 14, 23, 32, 41, 50 dup
 # 15, 24, 33, 42, 51, 60
 #
 # # 23, 32, 41, 50 dup
 # # 24, 33, 42, 51, 60 dup
 # 25, 34, 43, 52, 61
 #
 # # 33, 42, 51, 60 dup
 # # 34, 43, 52, 61 dup
 # 35, 44, 53, 62
 #
 #
 # bl to tr
 # 30, 41, 52, 63
 # 20, 31, 42, 53, 64
 # 10, 21, 32, 43, 54, 65
 # 00, 11, 22, 33, 44, 55
 # 01, 12, 23, 34, 45
 # 02, 13, 24, 35
 #
 # tl to br
 # 30, 21, 12, 03
 # 40, 31, 22, 13, 04
 # 50, 41, 32, 23, 14, 05
 # 60, 51, 42, 33, 24, 15
 # 61, 52, 43, 34, 25
 # 62, 53, 44, 35