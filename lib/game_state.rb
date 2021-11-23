module GameState
  def save_game
    Dir.mkdir 'output' unless Dir.exist? 'output'
    File.open('output/save_file.yaml', 'w') { |f| f.write save_to_yaml }
  end

  def save_to_yaml
    YAML.dump(
      'keyword' => @keyword,
      'letters_used' => @letters_used,
      'incorrect_letters_used' => @incorrect_letters_used,
      'turns' => @turns
    )
  end
end
