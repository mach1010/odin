def substrings (string, dictionary)
  substrings = Hash.new(0)
  words = string.downcase!.split(' ')
  words.each { |word| dictionary.each { |x| substrings[x] += 1 if word.match(x) } }
  substrings
end