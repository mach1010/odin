def kaprekar?(k)
  square = k**2
  array = square.to_s.split('').map {|x| x.to_i}
  len = array.length
  
  (0..len - 1).each do |x|
    if (array[0..x].join.to_i + array[(x+1)..-1].join.to_i) == k
      return true
    end
  end
    false
end
