require 'spec_helper'

module Mastermind
  describe Game do
    context 'When starting the game' do
      # before :each do
      #   @game = Game.new
      # end
      subject(:game) { Game.new }
      # let(:game) { Game.new }
      # before { @game = Game.new }
      
      it { is_expected.to be_a Game }

      it 'should #start the game' do
        allow(game).to receive(:make_player).and_return nil
        allow(game).to receive(:set_rounds).and_return nil
        expect{ game.start }.to output(/Welcome/).to_stdout
      end
      it '#start should call #make_player' do
        allow(game).to receive(:make_player).and_return("Enter a player name")
        allow(game).to receive(:set_rounds).and_return("How many rounds?")
        expect(game.start).to eq "Enter a player name"
        # allow(game).to receive(:make_player)
        # allow(game).to receive(:set_rounds).and_return 'rounds'
        #
        # expect(game.start). to eq 'rounds'
      end
      it '#set_rounds should only take 8,10,or 12 as input'
      it '#make_player makes a new player' 
      it 'should begin the game' 
    end
    
    context 'gameplay with player as codebreaker'
    
    context 'gameplay with player as codemaker'
  end
end


# describe Player do
#   describe "#move_computer" do
#     it "returns a line from stdin" do
#       subject.stub!(:gets) {"penguin banana limousine"}
#       STDOUT.should_receive(:puts).with("computer move")
#       subject.move_computer("O").should == "penguin banana limousine"
#     end
#   end
# end