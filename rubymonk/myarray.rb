class MyArray
  attr_reader :array

  def initialize(array)
    @array = array
  end

  def sum(initial_value = 0)
    # your code here
    total = 0
    if block_given?
      @array.each {|x| total += yield x}
    else
      total = @array.reduce(:+)
    end
    total + initial_value
  end
end