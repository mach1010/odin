def number_shuffle(number)
  # your code here
  numbers = number.to_s.split('').map {|x| x.to_i}
  uniques = []
  numbers.permutation(numbers.length) {|p| uniques << p}
  uniques.map {|x| x.join.to_i}
end