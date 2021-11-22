# frozen_string_literal: true
require 'yaml'
require_relative 'input_output'
require_relative 'player_input'

class Hangman
  include InputOutput
  attr_reader :keyword, :turns, :incorrect_letters_used

  def initialize
    @keyword = random_select_word
    @turns = 10
    @player_input = PlayerInput.new
    @incorrect_letters_used = []
  end

  def letters_used
    @player_input.letters_used
  end

  def random_select_word
    File.readlines('5desk.txt').sample.chomp
  end

  def game
    until @turns.zero?
      reveal_key_letters
      print "\nEnter a letter to guess the hidden word:\n>"
      guess = @player_input.validate
      guess_results(guess)
      save_game
      check_player_won
    end
    player_lost
  end

  def guess_results(guess)
    if !keyword.include?(guess)
      @turns -= 1
      incorrect_letters_used << guess
      print "Incorrect!\nIncorrect letters used: #{incorrect_letters_used}\n"
      puts "You have #{turns} turns left."
    else
      puts "correct! you guessed the correct word #{keyword}!"
    end
  end

  def check_player_won
    player_won if (keyword.split('').map(&:downcase) - letters_used).empty?
  end

  def player_won
    puts "You won!"
    play_again
  end

  def player_lost
    puts "You lose! the correct word is #{keyword}"
    play_again
  end

  def play_again
    print "Play again? (y/n)\n>"
    input = gets.chomp
    exit if input.upcase == 'N'
    new_game if input.upcase == 'Y'
    puts "Invalid input.\n"
    play_again
  end

  def new_game
    Hangman.new.game
  end

  def reveal_key_letters
    keyword.split('').map do |letter|
      letters_used.include?(letter.downcase) ? (print letter) : (print '-')
    end
  end
end

play = Hangman.new
# p play.reveal_key_letters
play.game
