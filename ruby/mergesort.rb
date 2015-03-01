def merge_sort(ary)
  return ary if ary.size <= 1
  left, right = ary.shift(ary.size/2), ary
  merge(merge_sort(left), merge_sort(right))
end

def merge(left, right)
  sorted = []
  until left.empty? || right.empty?
    sorted << ((left.first <= right.first) ? left.shift : right.shift)
  end
  sorted.concat(left).concat(right)
end

