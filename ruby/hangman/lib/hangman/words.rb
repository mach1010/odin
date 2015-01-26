class Words
  # handle dictionary creation, random word choice, word reveals when solving
  attr_reader :word, :word_array
  attr_accessor :word_hidden
  
  def initialize
   @word = random_word
   @word_array = @word.chars
   @word_hidden = '_' * @word.length
  end  
  
  def update_hidden_word(letter)
    @word_array.each_with_index do |char, index| 
      @word_hidden[index] = char if char == letter
    end
  end

  # create wordlist of words 5..12 length excluding proper nouns(capitalized)
  def self.create_dictionary(file)
    File.open(file).select do |word|
      word[0] != word[0].upcase &&
      word.chomp!.length.between?(5,10)
    end
  end
  DICTIONARY = create_dictionary('hangman/5desk.txt')

  
  private
    def random_word
      DICTIONARY[rand(0..(DICTIONARY.length - 1))]
    end
end
