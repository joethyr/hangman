module GameState
  def save_game
    Dir.mkdir 'output' unless Dir.exist? 'output'
    File.open('output/save_file.yaml', 'w') { |file| file.write save_to_yaml }
  end

  def save_to_yaml
    YAML.dump(
      'keyword' => @keyword,
      'letters_used' => @letters_used,
      'incorrect_letters_used' => @incorrect_letters_used,
      'turns' => @turns
    )
  end

  def load_saved_game
    file = YAML.safe_load(File.read('output/save_file.yaml'))
    @keyword = file['keyword']
    @letters_used = file['letters_used']
    @incorrect_letters_used = file['incorrect_letters_used']
    @turns = file['turns']
  end
end
