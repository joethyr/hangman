# handles the input from players
class PlayerInput
  attr_reader :letters_used, :incorrect_letters_used

  def initialize
    @letters_used = []
  end

  def validate
    input = gets.chomp.downcase
    if input.length != 1 || input.match(/[^a-z]/i)
      print "Invalid input. Please enter a letter from A-Z:\n>"
      validate
    elsif letters_used.include?(input)
      print "Input already used. Please enter a letter from A-Z:\n>"
      validate
    else
      letters_used << input
      input
    end
  end
end
