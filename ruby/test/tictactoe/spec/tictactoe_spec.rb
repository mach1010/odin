require 'spec_helper'

describe Game do
  subject(:game) { Game.new }
  it {is_expected.to be_a Game}
  
  it 'starts with player X' do
    expect(game.instance_variable_get(:@player_turn)).
      to eql game.instance_variable_get(:@player1)
  end
  
  describe '#play' do
    
    context 'controls in a loop when game is running' do
      before :example do
        allow(game).to receive_messages(
          draw_board: nil, 
          get_player_move: nil,  
          player_takes_turn: nil,
          next_player: nil, 
          play_again?: nil
        )
        allow(game).to receive(:game_over?).
          and_return(false, false, false, true)
      end

      it 'calls game_board method to draw gameboard on every turn' do
        expect(game).to receive(:draw_board).exactly(4).times
        game.play
      end

      it 'calls player_takes_turn' do
        expect(game).to receive(:player_takes_turn).exactly(4).times
        game.play
      end

      it 'calls play_again? only after game_over? is true' do
        expect(game).to receive(:play_again?).exactly(1).times
        game.play
      end
    end
    
    context 'when a player makes a move' do
      before :example do
        allow(game).to receive_messages(
          draw_board: nil,
          play_again?: nil,
          game_over?: true
        )
        allow(game).to receive(:get_player_move).and_return(1)
      end
      
      it 'records move on player' do
        expect { game.play }.to change{game.instance_variable_get(:@player1).moves.count}.by(1)
      end
      
      it 'records move on board' do
        game.play
        expect(game.instance_variable_get(:@positions)).to include('X')
      end
      
      
      it 'checks for game_over?' do
        expect(game).to receive(:game_over?)
        game.play
      end
      
      it 'switches players' do
        allow(game).to receive(:game_over?).and_return(false, true)
        game.play
        expect(game.instance_variable_get(:@player_turn)).
          to eql game.instance_variable_get(:@player2)
      end
    end
    
    context 'when a player wins' do
      before :example do
        player1 = double('player1', icon: :X, moves: [2,3])
        player2 = double('player2', icon: :O, moves: [4,5])
        game.instance_variable_set(:@player1, player1)
        game.instance_variable_set(:@player2, player2)
        game.instance_variable_set(:@positions, [1,'X','X','O','O',6,7,8,9])
        
        allow(game).to receive_messages(
          draw_board: nil,
          play_again?: nil,
        )
        allow(game).to receive(:get_player_move).and_return(1)

      end
      
      it 'ends the loop and calls play_again?' do
        allow(game).to receive(:game_over?).and_return(false, true)
        expect(game).to receive(:play_again?).exactly(1).times
        game.play
      end
      
      it 'congratulates the winner' do
        expect{ game.play }.to output("X wins! Congratulations!\n").to_stdout
      end
      
      xit 'starts a new game if player chooses' do
        # can't sort how to expect Game.new.play from Game#play_again?
        # game = instance_double("Game")
        allow(game).to receive(:game_over?).and_return(false, true)
        double(Game, new:nil)
        allow(game).to receive(:play_again?).and_return('y')
        # klass = class_double(Game, new: nil)
        # expect_any_instance_of(Game).to receive(:new)
        game.play
        expect(Game).to receive(:new)
      end
    end
  end
end
