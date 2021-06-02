# frozen_string_literal: false

require 'colorize'

module ConnectFourGame
  # Module for checking legal moves, checking if game has a winner, etc
  module Logic
    # constants for display, rules
    TOKEN_1 = '①'.blue.freeze
    TOKEN_2 = '②'.red.freeze
    DIVIDER = ' | '.bold.freeze
    EMPTY = '_'.freeze

    SIZE_COLS = 7
    SIZE_ROWS = 6

    def valid_move?(col)
      @state[col] && @state[col].size < SIZE_ROWS
    end

    def game_over?; end

    def winner; end

    def check_rows; end

    def check_cols; end

    def check_diags; end
  end
end
