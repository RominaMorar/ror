def weirdcase(string)
  words = string.split

  words.each_with_index do |word, i|
    new_word = ""
    word.chars.each_with_index do |char, j|
      new_word << (j.even? ? char.upcase : char.downcase)
    end
    words[i] = new_word
  end

  return words.join(" ")
end
