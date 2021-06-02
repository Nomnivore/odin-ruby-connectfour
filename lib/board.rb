# frozen_string_literal: false

require_relative './logic'

module ConnectFourGame
  # Manages board state
  class Board
    include Logic

    attr_reader :state

    def initialize(state = Array.new(SIZE_COLS) { [] })
      raise(OddSizeError) if (SIZE_COLS * SIZE_ROWS).even?

      @state = state
    end

    def to_s
      (SIZE_ROWS - 1).downto(0) do |row|
        print DIVIDER
        @state.each do |col|
          print col[row] || EMPTY
          print DIVIDER
        end
        print "\n"
      end
      puts "   #{[*1..SIZE_COLS].join('   ')}".green
    end

    def drop_piece(col, token)
      return unless valid_move?(col)

      piece = case token
              when :p1 then TOKEN_1
              when :p2 then TOKEN_2
              end

      @state[col].append(piece)
    end
  end

  # custom error when board size constants are set incorrectly
  class OddSizeError < StandardError
    def message
      'Board size constants must result in an even number when multiplied'
    end
  end
end
