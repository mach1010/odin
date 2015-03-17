module ChessMoves
  # anticipating final project- this module should be reusable by all pieces
  def valid?(position)
    position.all? {|x| x >= 0 && x < 8}
  end
  
  class Node < Struct.new :location, :parent, :children
  end

  def get_legal_moves(parent, vectors)
    vectors.map do |vector| 
    Node.new([vector.first + parent.location.first, vector.last +
              parent.location.last], parent, [])
    end.select {|position| valid?(position.location) }
  end
  
  def get_vectors(piece)
    #TODO multiplier? ex. rook can move any legal empty spaces in each legal dir
    vectors = { 
    pawn:   [ [1,0], [2,0] ],
    rook:   [ [-1,0], [1,0], [0,-1], [0,1] ],
    knight: [ [-2,-1], [-2,1], [-1,-2], [-1,2], [1,-2], [1,2], [2,-1], [2,1] ],
    bishop: [ [-1,-1], [-1,1], [1,-1], [1,1] ],
    queen:  [ [-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1] ],
    king:   [ [-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1] ]
    }
    vectors[piece]
  end

  def make_node(location, parent, children=[])
    Node.new(location, parent, children)
  end
end

class Knight
  include ChessMoves
  
  def initialize
    @vectors = get_vectors :knight
  end
  
  def knight_moves(start, goal)
    return 'invalid paramaters' unless valid?(start + goal)
    return "start and goal positions are the same" if start == goal
    show_results get_path(start, goal)
  end    

  def show_results(path)
    puts "You made it in #{path.size - 1} #{path.size <= 2 ? 'move' : 'moves'}! Here's your path:"
    path.each {|x| p x}
  end

  private
    def get_path(start, goal)
      current = find_goal(start, goal)
      path =[current.location]
      while current.parent do
        path.unshift current.parent.location
        current = current.parent
      end
      path
    end

    def find_goal(start, goal)
      queue = [make_node(start, nil)]
      while !queue.empty? do
        current = queue.shift
        return current if current.location == goal
        moves = get_legal_moves(current, @vectors)
        current.children = moves
        moves.each { |node| queue.push(node) }
      end
    end 
end
