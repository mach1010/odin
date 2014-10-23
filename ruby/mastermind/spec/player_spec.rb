require 'spec_helper'

# Mastermind module contains all code for the mastermind game project
module Mastermind
  describe Player do
    let(:player) { Player.new(name: 'Player1', role: :codebreaker) }
    context '#initialize' do
      it 'should create a player' do
        expect(player).to be_a Player
      end
      it 'should have codebreaker/codemaker attribute' do
        expect(player.role).to eq :codebreaker
      end
      it 'should accept a player name' do
        expect(player.name).to eq 'Player1'
      end
      it 'should keep number of games played by player' do
        expect(player.games_played).to eq 0
      end
      it 'should keep number of games won by player' do
        expect(player.games_won).to eq 0
      end
    end
    
    context '#set_role' do
      it 'should change player role' do
        player.set_role(:codemaker)
        expect(player.role).to eq :codemaker
      end
    end
  end
end
