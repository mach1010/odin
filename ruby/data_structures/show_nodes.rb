  
def levels(current, parents = [current], level_ary = [[current]])
  if parents.compact.empty?
    level_ary.pop
    return level_ary.map {|x| x.map{|y| y ? y.value.to_s : 'x'}}
  end
  level = []
  parents.each do |parent|
    if parent
      level << (parent.left ? parent.left : nil)
      level << (parent.right ? parent.right : nil)
    else
      2.times {level << nil}
    end
    parents = []
  end
  level_ary << level
  levels(current, level, level_ary)
end


def print(root)
  level_array = levels(root)
  base = level_array.last.join.size
  return "BST base wider than 80chars, aborting..." if base > 80
  level_array.each_with_index do |level, index|
    # offset = ( base - level.join.size )/( 2 ** ( index ) )
    offset = base / ( 2 ** ( index ) )
    level_string = ''
    level.each do |x|
      index_number = offset - x.size >= 0 ? (offset - x.size) : 0
      level_string << ( ' ' * index_number) + x + ( ' ' * (offset) )
    end
    puts level_string
  end
  nil
end


# Using algorithms in search to create a BST, you can use the following
# syntax to create a visual BST (probably not more than 6 child nodes deep...)
# print(root_node_here)