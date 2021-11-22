# frozen_string_literal: true
require 'yaml'
require_relative 'input_output'

class Hangman
  include InputOutput
  attr_reader :keyword, :letters_used, :turns, :incorrect_letters_used

  def initialize
    @keyword = random_select_word
    @letters_used = []
    @incorrect_letters_used = []
    @turns = 10
  end

  def random_select_word
    File.readlines('5desk.txt').sample.chomp
  end

  def game
    until @turns.zero?
      hide_display_word
      print "\nEnter a letter to guess the hidden word:\n>"
      player_input = validate_player_input
      check_guess(player_input)
      save_game
      check_player_won
    end
    player_lost
  end

  def validate_player_input
    input = gets.chomp.downcase
    if input.length != 1 || input.match(/[^a-z]/i)
      print "Invalid input. Please enter a letter from A-Z:\n>"
      validate_player_input
    elsif letters_used.include?(input)
      print "Input already used. Please enter a letter from A-Z:\n>"
      validate_player_input
    else
      letters_used << input
      input
    end
  end

  def check_guess(player_input)
    if !keyword.include?(player_input)
      @turns -= 1
      incorrect_letters_used << player_input
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

  def hide_display_word
    keyword.split('').map do |letter|
      letters_used.include?(letter.downcase) ? (print letter) : (print '-')
    end
  end
end

play = Hangman.new
# p play.display_word
play.game
