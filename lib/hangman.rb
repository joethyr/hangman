# frozen_string_literal: true

def randomly_select_word
  puts File.readlines('5desk.txt').sample
end
