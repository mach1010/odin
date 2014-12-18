module Mastermind
  # Code class creates a code of random colors based on an index number that
  # specifies how many positions to instantiate
  class Code
    attr_reader :code
    class << self; attr_reader :colors; end
    @colors = [:yellow, :red, :blue, :green, :orange, :purple]

    def initialize(index)
      @code = generate_code(index)
    end

    def colors
      self.class.colors
    end

    private
    def generate_code(index)
      code = []
      index.times { code << colors[rand(0..5)] }
      code
    end
  end
end
