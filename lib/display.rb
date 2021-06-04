# frozen_string_literal: true

require 'colorize'

module ConnectFourGame
  # Extra methods for displaying stuff to the console
  module Display
    def display_title
      figlet = <<~'FIG'
          ____                            _     _____
         / ___|___  _ __  _ __   ___  ___| |_  |  ___|__  _   _ _ __
        | |   / _ \| '_ \| '_ \ / _ \/ __| __| | |_ / _ \| | | | '__|
        | |__| (_) | | | | | | |  __/ (__| |_  |  _| (_) | |_| | |
         \____\___/|_| |_|_| |_|\___|\___|\__| |_|  \___/ \__,_|_|
      FIG
      print figlet.blue
      horiz_line
    end

    def display_rules
      rules = <<~'RUL'
        Two players will take turns dropping a token into one of #{Logic::SIZE_ROWS} columns.
        If a player gets 4 of their tokens to appear consecutively and either
        horizontally, vertically, or diagonally, they win.
        If the board fills up and nobody has won, the game is over.
        This game is currently Human vs Human.

      RUL
      print rules
      horiz_line
      puts 'Are you ready to play?'
    end

    def display_winner
      winner = @board.winner
      msg = winner.positive? ? "Player #{winner} wins!" : "It's a tie!"
      puts "Game over. #{msg}"
    end

    def horiz_line
      puts '============================================================='
        .blue.bold
    end
  end
end
