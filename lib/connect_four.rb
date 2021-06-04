# frozen_string_literal: false

require_relative './board'
require_relative './display'

# TODO: Script methods

module ConnectFourGame
  # Class that controls the game flow of a Connect Four game.
  class ConnectFour
    include Display

    def initialize(board = Board.new)
      @board = board
    end

    # script method, game flow
    def play
      display_title
      display_rules
      player_turns
      display_winner
    end

    # script method, looping player turns
    def player_turns # rubocop:disable Metrics/MethodLength
      until @board.game_over?
        @board.to_s
        puts "Player #{@board.current_player}, it's your turn."
        move = player_input
        while move.nil?
          puts 'Invalid move. Please enter a number corresponding to a non-full column.'
          move = player_input
        end
        @board.drop_piece(move, @board.current_player)
      end
      @board.to_s
    end

    def player_input
      turn = gets.chomp.to_i
      return if turn.zero?

      @board.valid_move?(turn - 1) ? turn : nil
    end
  end
end
