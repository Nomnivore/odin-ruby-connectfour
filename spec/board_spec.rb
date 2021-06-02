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
    let(:state) do
      full_col = []
      described_class::SIZE_ROWS.times do
        full_col << described_class::TOKEN_1
      end
      [
        full_col,
        [],
        [described_class::TOKEN_1, described_class::TOKEN_1]
      ]
    end
    subject(:game_valid) { described_class.new(state) }

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

  describe '#drop_piece' do
    subject(:game_drop) { described_class.new }
    context 'when the move is not valid' do
      it 'does not add a piece to the column' do
        allow(game_drop).to receive(:valid_move?).and_return false
        expect { game_drop.drop_piece(0, :p1) }.not_to(change { game_drop.state[0].size })
      end
    end

    context 'when the move is valid' do
      let(:token_p1) { described_class::TOKEN_1 }
      let(:token_p2) { described_class::TOKEN_2 }
      it 'adds the player 1 token to the column' do
        allow(game_drop).to receive(:valid_move?).and_return true
        game_drop.drop_piece(6, :p1)
        expect(game_drop.state[6]).to include(token_p1)
      end

      it 'adds the player 2 token to the column' do
        allow(game_drop).to receive(:valid_move?).and_return true
        game_drop.drop_piece(3, :p2)
        expect(game_drop.state[3]).to include(token_p2)
      end
    end
  end

  describe '#winner' do
    p1 = described_class::TOKEN_1
    p2 = described_class::TOKEN_2

    context 'when not game_over?' do
      it 'returns nil' do
        allow(subject).to receive(:game_over?).and_return false
        expect(subject.winner).to be nil
      end
    end

    context 'when player 1 has won' do
      # even tho #game_over? will be stubbed, we should set up
      # a winner-like situation for the method.
      state = [
        [],
        [p2, p2, p2],
        [],
        [],
        [p1, p1, p1, p1],
        []
      ]
      subject(:game_p1) { described_class.new(state) }

      it 'returns the p1 symbol' do
        allow(game_p1).to receive(:game_over?).and_return true
        expect(game_p1.winner).to be(:p1)
      end
    end

    context 'when player 2 has won' do
      # even tho #game_over? will be stubbed, we should set up
      # a winner-like situation for the method.
      state = [
        [p1, p1],
        [p2],
        [p2],
        [p2, p1],
        [p2],
        []
      ]
      subject(:game_p2) { described_class.new(state) }

      it 'returns the p2 symbol' do
        allow(game_p2).to receive(:game_over?).and_return true
        expect(game_p2.winner).to be(:p2)
      end
    end
  end

  describe '#check_cols' do
    p1 = described_class::TOKEN_1
    p2 = described_class::TOKEN_2

    context 'with 4 matching tokens in a row' do
      state = [
        [],
        [p2],
        [],
        [p2, p1, p1, p1, p1, p2],
        []
      ]
      subject(:col_match) { described_class.new(state) }
      it 'is true' do
        expect(col_match.check_cols).to be true
      end
    end

    context 'when not 4 in a row' do
      state = [
        [],
        [p1, p2, p1, p2],
        [p1, p1, p1, p2, p2, p2],
        []
      ]
      subject(:col_no_match) { described_class.new(state) }
      it 'is false' do
        expect(col_no_match.check_cols).to be false
      end
    end

    context 'when empty' do
      subject(:col_empty) { described_class.new }
      it 'is false' do
        expect(col_empty.check_cols).to be false
      end
    end
  end

  describe '#check_rows' do
    p1 = described_class::TOKEN_1
    p2 = described_class::TOKEN_2

    context 'with 4 in a row' do
      state = [
        [p2, p2],
        [],
        [p2],
        [p2, p1],
        [p2, p1],
        [p1, p1],
        [p1, p1]
      ]
      subject(:row_match) { described_class.new(state) }
      it 'is true' do
        expect(row_match.check_rows).to be true
      end
    end

    context 'when not 4 in a row' do
      state = [
        [p2, p1],
        [p1, p2],
        [p2, p1],
        [p1, p2],
        [p1, p2]
      ]
      subject(:row_no_match) { described_class.new(state) }
      it 'is false' do
        expect(row_no_match.check_rows).to be false
      end
    end

    context 'when empty' do
      subject(:row_empty) { described_class.new }
      it 'is false' do
        expect(row_empty.check_rows).to be false
      end
    end
  end

  describe '#check_fwd_diags' do
    p1 = described_class::TOKEN_1
    p2 = described_class::TOKEN_2

    context 'with 4 in a row' do
      state = [
        [p2],
        [p2, p1],
        [p1, p1],
        [p1, p2, p1],
        [p2, p1, p2, p1],
        [p1, p1, p2, p2, p1],
        []
      ]
      subject(:fwd_match) { described_class.new(state)}
      it 'returns true' do
        expect(fwd_match.check_fwd_diags).to be true
      end
    end

    context 'when not 4 in a row' do
      state = [
        [p2, p1, p1, p1, p1],
        [p2],
        [p2],
        [p2],
        [p2]
      ]
      subject(:fwd_no_match) { described_class.new(state) }
      it 'returns false' do
        expect(fwd_no_match.check_fwd_diags).to be false
      end
    end

    context 'when empty' do
      subject(:fwd_empty) { described_class.new }
      it 'returns false' do
        expect(fwd_empty.check_fwd_diags).to be false
      end
    end
  end

  describe '#check_bck_diags' do
    p1 = described_class::TOKEN_1
    p2 = described_class::TOKEN_2

    context 'with 4 in a row' do
      state = [
        [p2, p1, p2, p1, p1],
        [p2, p2, p1, p1],
        [p1, p2, p1],
        [p2, p1],
        [],
        [p2],
        []
      ]
      subject(:bck_match) { described_class.new(state) }
      it 'returns true' do
        expect(bck_match.check_bck_diags).to be true
      end
    end

    context 'when not 4 in a row' do
      state = [
        [p2, p1, p1, p1, p1],
        [p2],
        [p2],
        [p2],
        [p2]
      ]
      subject(:bck_no_match) { described_class.new(state) }
      it 'returns false' do
        expect(bck_no_match.check_bck_diags).to be false
      end
    end

    context 'when empty' do
      subject(:bck_empty) { described_class.new }
      it 'returns false' do
        expect(bck_empty.check_bck_diags).to be false
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
