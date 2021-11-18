# frozen_string_literal: true

class Hangman
  attr_reader :keyword, :letters_used

  def initialize
    @keyword = random_select_word
    @letters_used = []
  end

  def random_select_word
    File.readlines('5desk.txt').sample.chomp
  end

  def game
    turns = 10
    until turns.zero?
      hide_display_word
      print "\nEnter a letter for the hidden word:\n>"
      player_input
    end
  end

  def player_input
    input = gets.chomp
    if input.length != 1 || input.match(/[^a-z]/)
      puts input
      puts "invalid input. Please enter a letter:"
      player_input
    elsif letters_used.include?(input)
      puts "input already used. Please enter a letter:"
      player_input
    else
      letters_used << input
    end
  end

  def display_word
    keyword.split('')
  end

  def hide_display_word
    display_word.map do |letter|
      if letters_used.include?(letter)
        letter
      else
        print "-"
      end
    end
  end

end

play = Hangman.new
# play.test
play.game
