# frozen_string_literal: false

require_relative '../lib/connect_four'


describe ConnectFourGame::ConnectFour do
  # * ConnectFour Tests


  # * Display Tests

  describe '#display_winner' do
    context 'when the game is a tie' do
      let(:dbl_board) { instance_double('Board') }
      subject(:tie_game) { described_class.new(dbl_board) }
      
      it "displays a message containing 'tie'" do
        allow(dbl_board).to receive(:winner).and_return(0)
        expect { tie_game.display_winner }.to output(/tie/).to_stdout
      end
    end

    context 'when a single player has won' do
      let(:dbl_board) { instance_double('Board') }
      subject(:game_won) { described_class.new(dbl_board) }
      it 'displays a message for Player 1' do
        allow(dbl_board).to receive(:winner).and_return(1)
        expect { game_won.display_winner }.to output(/Player 1/).to_stdout
      end
      it 'displays a message for Player 2' do
        allow(dbl_board).to receive(:winner).and_return(2)
        expect { game_won.display_winner }.to output(/Player 2/).to_stdout
      end
    end
  end
end
