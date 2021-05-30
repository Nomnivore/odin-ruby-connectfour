# frozen_string_literal: false

require_relative './logic'

module ConnectFourGame
  # Manages board state
  class Board
    include Logic

    attr_reader :state

    def initialize(state = Array.new(SIZE_COLS) { [] })
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

    def sample
      puts "#{DIVIDER}#{TOKEN_1}#{DIVIDER}#{TOKEN_2}#{DIVIDER}#{EMPTY}#{DIVIDER}"
    end
  end
end
