class Node
  attr_accessor :value, :parent, :left, :right
  def initialize(opts)
    @value = opts[:value]
    @parent = opts[:parent]
    @left = opts[:left] 
    @right = opts[:right]
  end
end

class Tree
  attr_accessor :root, :nodes
  def initialize(ary)
    @ary = ary.clone
    @root = select_root(@ary)
    build_tree(@ary)
  end

  def build_tree(ary)
    ary.each {|val| create_node(val)}
  end

  def select_root(ary)
    val = ary.delete_at(rand(0...ary.size))
    Node.new(value: val, parent: nil, right: nil, left: nil )
  end
  
  def create_node(val)
    parent = find_parent(@root, val)
    if val > parent.value
      if parent.right
        right = parent.right
        parent.right = Node.new(value: val, parent: parent, right: right, left: nil)
      else
        parent.right = Node.new(value: val, parent: parent)
      end
    else
      if parent.left
        left = parent.left
        parent.left = Node.new(value: val, parent: parent, left: left, right: nil)
      else
        parent.left = Node.new(value: val, parent: parent)
      end
    end
  end

  def find_parent(current, val)
    return current if val <= current.value && !current.left ||
                      val > current.value && !current.right
    if val <= current.value
      find_parent(current.left, val)
    else
      find_parent(current.right, val)
    end
  end
  
  def breadth_first_search(val, current = @root, queue = [])
    return current if current.value == val
    if current.left
      current.left.value == val ? (return current.left) : 
                                   queue << current.left
    end
    if current.right
      current.right.value == val ? (return current.right) : 
                                    queue << current.right
    end
    queue.empty? ? nil : breadth_first_search(val, queue.shift, queue)
  end
  
  def depth_first_search(val, current = @root, stack=[])
    return current if current.value == val
    stack << current.right if current.right
    if current.left
      depth_first_search(val, current.left, stack)
    else
      stack.empty? ? nil : depth_first_search(val, stack.pop, stack)
    end
  end
  
  def get_nodes(current = @root, stack=[], nodes = [])
    return nodes if current == nil
    nodes << current
    stack << current.right if current.right
    current.left ? get_nodes(current.left, stack, nodes) :
                   get_nodes(stack.pop, stack, nodes)
  end
  
end

$ary =        [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
$ary_sorted = [1, 3, 4, 4, 5, 7, 7, 8, 9, 9, 23, 67, 324, 6345]

$t = Tree.new($ary)

puts "Breadth first search for 67: #{$t.breadth_first_search(67).value}"
puts "Depth first search for 67: #{$t.depth_first_search(67).value}"
p $t.get_nodes.map {|x| x.value}
