module Mastermind
  # Game class handles starting and running the game to a conclusion
  class Game
    # attr_accessor :player 
    # @total_rounds, @rounds_played = 0, 0
    
    def initialize
      @total_rounds
      @rounds_played = 0
      @turns
      @code = []
    end
    
    def start
      system('clear')
      puts "Welcome to Mastermind! Let's begin!"
      set_rounds
      make_player
    end

    def play
      puts 'Solve the code by guessing the correct combination. Colors can be repeated.'
      @rounds_played += 1
      @turns = 12
      make_code
      make_guess
    end

    private
    def set_rounds
      puts 'How many rounds would you like to play? (8, 10, or 12)?'
      rounds = gets.chomp
      if [8, 10, 12].include? rounds.to_i
        @total_rounds = rounds.to_i
        puts 'Great!'
        return
      else
        puts "I didn't understand that"
        set_rounds
      end
    end
    
    def make_player
      input = Hash.new
      puts "Enter a player name:"
      input[:name] = gets.chomp
      puts "Hi #{input[:name]}!"
      input[:role] = player_role
      player = Player.new(input)
      system('clear')
      puts 'player created!'
      puts "Name: #{player.name}\nRole: #{player.role}\nRounds: #{@total_rounds}"
    end
    
    def player_role
      puts "Would you like to play as code(M)aker or code(B)reaker? (M or B)"
      role = gets.chomp.downcase
      case role
      when 'b'
        puts 'Great! Codebreaker it is'
        :codebreaker
      when 'm'
        puts 'Awesome! Codemaker it is'
        :codemaker
      else
        puts "Sorry, I didn't understand that. Please enter (M or B)"
        player_role
      end
    end
      
    def make_code
      # Hard coded for index of 4 currently (4 colors in the code)
      @code = Code.new(4).code.map { |index| index.to_s[0] }
      puts "The code contains 4 colors"
    end

    def make_guess
      color_options = Code.colors.map { |color| '(' + color.to_s[0] + ')' + color.to_s[1..-1] }
      puts "Enter any combination of #{ color_options.join(' ') }"
      guess = gets.chomp.downcase.delete(' ').split('')
      @turns -= 1
      win?(guess)
    end
      
    def win?(guess)
      # puts "your: #{guess}"
      # puts "code: #{@code}"
      if guess == @code
        puts "YOU WON in only #{12 - @turns} turns! Well done!"
        puts "You have played #{@rounds_played} out of #{@total_rounds} rounds."
        self.play
      else
        @turns == 0 ? lose : feedback(guess)
      end
    end
    
    def lose
      puts "Sorry, you didn't guess the code in time! um... BOOM!"
      puts''
      self.play
    end
    
    def feedback(guess)
      result = []
      temp_code = @code.dup
      guess.each_index do |index|
        if guess[index] == temp_code[index] 
          guess[index], temp_code[index] = 0, nil #delete so we don't double count a color
          result << 'O'
        end
      end
      guess.each do |guess|
        temp_code.each_with_index do |code, index|
          # Sprint guess, temp_code
          if guess == code
            guess, temp_code[index] = 0, nil
            result << 'X'
          end
        end
      end
      puts "result: #{result.shuffle.join(' ') }"
      puts "#{@turns} turns left"
      puts
      make_guess
    end
  end
end