def stock_picker(arr)
  diff, date_array = 0, []
  arr.repeated_combination(2).each do |x, y|
    if y - x > diff
      diff = y - x
      date_array = [arr.index(x), arr.index(y)]
    end
  end
  date_array
end