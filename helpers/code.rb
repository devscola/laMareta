module Code

  def generate
    characters = [('a'..'z'), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten
    string = (0...10).map { characters[rand(characters.length)] }.join

    string
  end
end