require 'yaml'
require_relative 'hangman/words'
require_relative 'hangman/game'
  
game = Game.new
game.start_game
