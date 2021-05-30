# frozen_string_literal: false

require_relative './board'
require_relative './display'

module ConnectFourGame
  # Class that controls the game flow of a Connect Four game.
  class ConnectFour
    include Display

    def initialize(board = Board.new)
      @board = board
    end

    def play; end
  end
end
