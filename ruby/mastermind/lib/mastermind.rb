require_relative 'mastermind/version'
require_relative 'mastermind/code'
require_relative 'mastermind/player'
require_relative 'mastermind/game'

# Mastermind module contains the codebase for the mastermind game
module Mastermind
  game = Game.new
  game.start
  game.play
end
