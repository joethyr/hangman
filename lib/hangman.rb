# frozen_string_literal: true
require 'yaml'
require_relative 'game_state'

class Hangman
  include GameState
  attr_reader :keyword, :turns, :incorrect_letters_used, :letters_used

  def initialize
    @keyword = random_select_word
    @turns = 10
    @incorrect_letters_used = []
    @letters_used = []
  end

  def random_select_word
    File.readlines('5desk.txt').sample.chomp
  end

  def game
    until @turns.zero?
      reveal_key_letters
      guess = validate_input
      guess_results(guess)
      check_player_won
    end
    player_lost
  end

  def validate_input
    print "\nEnter a letter to guess the hidden word:\n>"
    input = gets.chomp.downcase
    return input_save_game if input.downcase == 'save'
    return input_invalid if input.length != 1 || input.match(/[^a-z]/i)
    return input_reused if letters_used.include?(input)

    letters_used << input
    input
  end

  def input_save_game
    save_game
    print 'Your game has now been saved!'
    validate_input
  end

  def input_invalid
    print "Invalid input."
    validate_input
  end

  def input_reused
    print "Input already used."
    validate_input
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
