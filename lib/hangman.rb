# frozen_string_literal: true

class Hangman
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
      print "\nEnter a letter for the hidden word:\n>"
      player_input = validate_player_input
      check_guess(player_input)
      # check_player_won
    end
    # player_lost
  end

  def validate_player_input
    input = gets.chomp.downcase
    if input.length != 1 || input.match(/[^a-z]/i)
      puts input
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
      puts "incorrect letter!\nYou have #{turns} turns left."
      incorrect_letters_used << player_input
      print "incorrect letters used: #{incorrect_letters_used}\n"
    else
      puts "correct!"
    end
  end

  # def check_player_won
  #   if keyword ==
  # end

  # def player_won
  #   puts "You won!"
  #   play_again
  # end

  # def player_lost
  #   puts "You lose! the correct word is #{keyword}"
  #   play_again
  # end

  # def play_again
  #   print "Play again? (y/n)\n>"
  #   input = gets.chomp
  #   exit if input.upcase == 'N'
  #   game if input.upcase == 'Y'
  #   puts "Invalid input.\n"
  #   play_again
  # end

  def display_word
    keyword.split('')
  end

  def hide_display_word
    display_word.map do |letter|
      if letters_used.include?(letter.downcase)
        print letter
      else
        print "-"
      end
    end
  end

end

play = Hangman.new
p play.display_word
play.game
