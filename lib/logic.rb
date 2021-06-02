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

    def game_over?
      check_cols || check_rows ||
        check_fwd_diags || check_bck_diags
    end

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

    # TODO: refactor in a way that pleases rubocop
    def check_rows # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
      [*0..SIZE_ROWS].each do |row|
        [*0...@state.size].each do |col|
          3.times do |counter|
            begin
              break unless !@state[col + counter][row].nil? &&
                           @state[col + counter][row] == @state[col + counter + 1][row]
            rescue NoMethodError
              break
            end
            return true if counter == 2
          end
        end
      end
      false
    end

    # TODO: refactor in a way that pleases rubocop
    def check_cols # rubocop:disable Metrics/AbcSize
      [*0...@state.size].each do |col|
        [*0..SIZE_ROWS].each do |row|
          3.times do |counter|
            break unless !@state[col][row + counter].nil? &&
                         @state[col][row + counter] == @state[col][row + counter + 1]

            return true if counter == 2 # checks finished on ++ 0,1,2
          end
        end
      end
      false
    end

    # TODO: refactor in a way that pleases rubocop
    def check_fwd_diags # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      [*0...@state.size].each do |col|
        [*0..SIZE_ROWS].each do |row|
          3.times do |counter|
            begin
              break unless !@state[col + counter][row + counter].nil? &&
                           @state[col + counter][row + counter] == @state[col + counter + 1][row + counter + 1]
            rescue NoMethodError
              break
            end
            return true if counter == 2
          end
        end
      end
      false
    end

    # TODO: refactor in a way that pleases rubocop
    def check_bck_diags # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      [*0...@state.size].each do |col|
        [*0..SIZE_ROWS].each do |row|
          3.times do |counter|
            begin
              break unless !@state[col + counter][row - counter].nil? &&
                           @state[col + counter][row - counter] == @state[col + counter + 1][row - counter - 1]
            rescue NoMethodError
              break
            end
            return true if counter == 2
          end
        end
      end
      false
    end
  end
end
