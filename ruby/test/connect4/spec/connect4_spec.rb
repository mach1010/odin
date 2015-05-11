require 'spec_helper'

# These specs are a bit weak, although it was an informative challenge.
# Testing private methods is challenging and a somewhat divisive issue
# I am not a fan of production code being altered to allow for tests
# Yet I did for this test suite. I have yet to see even good testing be
# really loosely coupled and not warp the code. Still learning...
describe Connect4 do
  subject(:connect4) { Connect4.new }
  
  it {is_expected.to be_a Connect4}
  
  context 'when a new game is created' do
    before :each do
      @playerclass = Connect4::Player
      allow(@playerclass).to receive(:new)
    end
    
    it 'should create 2 players' do
      expect(@playerclass).to receive(:new).twice
      Connect4.new
    end
    
    it 'should start with player1' do
      expect(subject.instance_variable_get(:@player_turn)).to eq subject.instance_variable_get(:@player1)
    end
  end
  
  context 'when playing a game' do
    before :each do
      allow(connect4).to receive_messages(
        draw_board: nil,
        player_takes_turn: nil,
        play_again?: nil
      ) 
      allow(connect4).to receive(:game_over?).
        and_return(false, true)
    end
    
    after :each do
      connect4.play
    end
    
    it 'draws the game board' do
      expect(connect4).to receive(:draw_board).twice
    end
    
    it 'accepts player move' do
      expect(connect4).to receive(:player_takes_turn).twice
    end
    
    it 'checks for game_over?' do
      expect(connect4).to receive(:game_over?).twice
    end
    
    it 'offers to play again only after game over' do
      expect(connect4).to receive(:play_again?).once
    end
  end
  
  context 'when a player wins' do
    before :each do
      allow(connect4).to receive_messages(
        draw_board: nil,
        player_takes_turn: nil
      )
    end
    
    it 'determines when a player gets a horizontal win' do
      connect4.game_state = [[1],[1],[1],[1],[],[],[]]      
      expect(connect4.winner?).to be true
    end
    
    it 'determines when a player gets a vertical win' do
      connect4.game_state = [[0],[0],[0],[1, 1, 1, 1],[],[],[]]
      expect(connect4.winner?).to be true
    end
    
    it 'determines when a player gets a diagonal win' do
      connect4.game_state = [[1],[2, 1],[1, 2, 1],[2, 1, 2, 1],[],[],[]]
      expect(connect4.winner?).to be true
    end
  end
end