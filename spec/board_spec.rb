# rubocop:disable Metrics/BlockLength
# frozen_string_literal: false

require_relative '../lib/board'

# will have tests for Board methods as well as Logic methods

describe ConnectFourGame::Board do
  describe '#initialize' do
    context 'when initialized without arguments' do
      subject { described_class.new }
      it 'creates a blank state with the configured size' do
        size = described_class::SIZE_COLS
        expect(subject.state.size).to eq(size)
      end

      it 'has all empty columns' do
        expect(subject.state.all?(&:empty?)).to be true
      end
    end
  end

  describe '#valid_move?' do
    before do
      full_col = []
      described_class::SIZE_ROWS.times do
        full_col << described_class::TOKEN_1
      end
      state = [
        full_col,
        [],
        [described_class::TOKEN_1, described_class::TOKEN_1]
      ]
      subject(:game_valid) { described_class.new(state) }
      # TODO: fix everything above
    end
    context 'when the row is filled' do
      it 'is not a valid move' do
        expect(game_valid.valid_move?(0)).to be false
      end
    end

    context 'when the row is not filled' do
      it 'is a valid move' do
        expect(game_valid.valid_move?(2)).to be true
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
