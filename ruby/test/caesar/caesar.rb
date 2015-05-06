def caesar_cipher(string, shift)
  cipher = []
  string.each_char do |c|
    index = c.ord + shift
    if c =~ /\W/ #handle non-word chars
      cipher << c
    else #push shifted chars to cipher array
      cipher << (c =~ /[a-z]/ ? (((index - 'a'.ord) % 26) + 'a'.ord).chr : (((index - 'A'.ord) % 26) + 'A'.ord).chr)
    end
  end
  cipher.join
end