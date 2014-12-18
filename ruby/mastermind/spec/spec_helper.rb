require_relative '../lib/mastermind.rb'

def random_alpha(n)
  (('A'..'Z').to_a + ('a'..'z').to_a).sample(n).join
end

def random_num(n)
  (0..9).to_a.sample(n).join
end
