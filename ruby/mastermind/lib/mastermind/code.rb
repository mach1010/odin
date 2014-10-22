module Mastermind
  class Code
    attr_reader :code
    @@colors = [:yellow, :red, :blue, :green, :orange, :purlple]
    
    def initialize index
      @code = generate_code(index)
    end
    
    private
    
    def generate_code index
      code = []
      index.times { code << @@colors[rand(0..5)] }
      code
    end
  end
end
      
      
