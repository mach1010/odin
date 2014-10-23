module Mastermind
  # Player class stores player information
  class Player
    attr_reader :name, :games_played, :games_won
    attr_accessor :role
    def initialize(input)
      @name = input.fetch(:name)
      @role = input.fetch(:role)
      @games_played = 0
      @games_won = 0
    end

    def set_role(role)
      @role = role
    end

  end
end
