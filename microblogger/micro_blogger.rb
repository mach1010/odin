require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client
  
  def initialize
    puts "Initializing MicroBlogger"
    @client = JumpstartAuth.twitter
  end
end

# THIS PROJECT STOPS HERE. After numerous attempts to reclaim an old email,
# with which to setup a throwaway twitter account, I also tried setting up
# new emails in 3 locations. EVERY ONE required my mobile phone number. NO
# NO A THOUSAND TIMES NO. After finding a suitable victim email to sign up
# with twitter, guess what? Account denied, use our PHONE APP so we can get
# all your data by demanding unreasonable, intrusive, and what should be
# illegal access rights into said phone. I don't need or use twitter. I need
# the right to remain relatively anonymous and unmolested. Foolish demand?
# Maybe. At this point we are not far from fuzzy profiling in which just
# heuristic data will reveal us unambiguously. Such a rant for a forever
# buried comment in a ruby file, but that's how I roll I guess.