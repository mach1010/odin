def bubble_sort arr
  sorting = true
  while sorting
    i, sorting = 1, false  
    until i == arr.length
      if arr[i] < arr[i - 1]
        arr[i], arr[i - 1] = arr[i - 1], arr[i]
        sorting = true
      end
      i += 1
    end
  end
  arr
end


def bubble_sort_by arr
  sorting = true
  while sorting
    i, sorting = 1, false
    until i == arr.length
      if yield(arr[i], arr[i - 1]) > 0
        arr[i], arr[i - 1] = arr[i - 1], arr[i]
        sorting = true
      end
      i += 1
    end
  end
  arr
end