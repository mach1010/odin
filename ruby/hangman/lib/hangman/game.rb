class Game
  def initialize
    @game_word = Words.new
    @word_array = @game_word.word_array.clone
    @guess = ''
    @incorrect = []
    @correct = []
  end
  
  def start_game
    system('clear')
    puts "Welcome to hangman!"
    puts "You have to guess a hidden word before you're hung!"
    puts "You can guess a letter or the whole word on any turn."
    puts "10 incorrect guesses loses the game."
    puts "Press enter to begin, good luck!"
    gets
    play
  end
  
  def play
    lost if @incorrect.length >= 10
    game_board
    check_guess
  end

  def play_again
    puts 'play again? (y/n)'
    new_game = gets.chomp.downcase
    case new_game
      when 'y' 
        Game.new.play
      when 'n'
        puts 'Thanks for playing!'
        exit
      else
        puts "I didn't understand that."
        play_again
    end
  end
  
  private
  
    def check_guess
      puts "guess a letter or the entire word:"
      @guess = gets.chomp.downcase
      if @guess.length > 1 && win?
        won
      elsif  @incorrect.include?(@guess) || @correct.include?(@guess)
        puts "already guessed"
        check_guess
      else
        process_guess
        win? ? won : play
      end
    end 
    
    def process_guess
      if @word_array.delete(@guess)
        @correct << @guess
        @game_word.update_hidden_word(@guess)
      else 
        @incorrect << @guess
      end
    end
   
    def win?
      @guess == @game_word.word || @word_array.empty?
    end
  
    def won
      @game_word.word_hidden = @game_word.word
      game_board
      puts "WOOT, YOU WON!"
      play_again 
    end
  
    def lost
      @game_word.word_hidden = @game_word.word
      game_board
      puts "SORRY, YOU LOSE!"
      play_again
    end
    
    def game_board
      system('clear')
      puts"#{10 - @incorrect.length} misses left."
      draw_gallows
      puts "misses: #{@incorrect.join(', ')}"
      puts ''
      puts "your word: #{@game_word.word_hidden}"
    end
    
    def draw_gallows
      index = @incorrect.length
      gallows = [ ['  __________'],
                  ['  |       |'],
                  ['  |', '  |       0'],
                  ['  |','  |       |','  |      /|','  |      /|\ '],
                  ['  |','  |       |','  |     / |','  |     / | \ '],
                  ['  |','  |      /','  |      / \ '],
                  ['  |','  |     _|','  |     _| |_'],
                  ['__|__________']
                ]
      
      hangman = [ '00000000', '00100000', '00111000', '00121000', '00122000', 
                  '00132000', '00133000', '00133100', '00133110', '00133210',  
                  '00133220']
      puts ''
      gallows.each_with_index do |e, i| 
        puts e[hangman[index][i].to_i]
      end  
      puts ''              
    end
end