module Enumerable
  #my version of each
  def my_each
    # i = 0
    # while i < self.length
    #   yield self[i]
    #   i += 1
    # end
    # self
    for i in self
      yield i
    end
  end
  
  # my version of each with index
  def my_each_with_index
    i = 0
    while i < self.length
      yield self[i], i
      i += 1
    end
    self
  end
  
  # my version of select
  def my_select
    arr = []
    self.my_each {|x| arr << x if yield x}
    arr
  end

  # my version of all?
  def my_all?
    self.my_each {|x| return false if yield(x) != true}
    true
  end

  # my version of any?
  def my_any?
    self.my_each {|x| return true if yield(x) == true}
    false
  end

  # my version of none?
  def my_none?
    self.my_each {|x| return false if yield(x) == true}
    true
  end
  
  # my version of count
  def my_count
    i = 0
    self.my_each {|x| i += 1}
    i
  end
  
  # my version of map
  def my_map
    arr = []
    self.my_each {|x| arr << yield(x)}
    arr
  end
  
  # my version of inject
  def my_inject memo = 0
    sum = memo
    self.my_each {|v| sum = yield(sum, v) } 
    sum
  end

end