class Restaurant
  def initialize(menu)
    @menu = menu
  end

  def cost(*orders)
    # your code here
    total = 0 
    orders.each {|x| x.each {|i, j| total += @menu[i] * j }}
    total
  end
end