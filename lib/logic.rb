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

    def winner
      return unless game_over?

      p1_count = @state.flatten.count(TOKEN_1)
      p2_count = @state.flatten.count(TOKEN_2)

      return if p1_count.eql?(p2_count) # just in case game_over? returns something unexpected

      if p1_count > p2_count
        :p1
      else
        :p2
      end
    end

    def check_rows; end

    def check_cols
      [*0...@state.size].each do |col|
        [*0..SIZE_ROWS].each do |row|
          3.times do |counter|
            break unless !@state[col][row + counter].nil? && @state[col][row] == @state[col][row + counter + 1]

            return true if counter == 3 # checks finished
          end
        end
      end
      false
    end

    def check_diags; end
  end
end
