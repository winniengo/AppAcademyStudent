class PolyTreeNode
  attr_reader :value
  attr_accessor :children, :parent

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(parent)
    @parent.children.delete(self) unless @parent.nil?
    @parent = parent
    parent.children << self unless parent.nil? || parent.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "not a child" unless children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if value == target_value

    children.each do |child|
      found_node = child.dfs(target_value)
      return found_node unless found_node.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue += current_node.children
    end
    nil
  end
end

# n1 = PolyTreeNode.new(0)
# n2 = PolyTreeNode.new(1)
# n3 = PolyTreeNode.new(2)
# n4 = PolyTreeNode.new(3)
#
# n1.add_child(n2)
# n1.add_child(n3)
# n2.add_child(n4)

# p n1.dfs(3)
# n1.bfs(2)

if file_name ==
