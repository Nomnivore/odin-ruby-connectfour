# frozen_string_literal: true

require 'colorize'

module ConnectFourGame
  # Extra methods for displaying stuff to the console
  module Display
    def title
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
    
    def horiz_line
      puts '============================================================='
        .blue.bold
    end
  end
end
