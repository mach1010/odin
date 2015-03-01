def fibs(n)
  (2...n).inject([0,1]) {|ary, val| ary << ary[-2] + ary[-1] }
end

def fibs_rec(n, ary=[0,1])
  return ary if n == 1
  ary << ary[-2] + ary[-1]
  fibs_rec(n-1, ary)
end

fibs_rec 10 # => [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55]


  
