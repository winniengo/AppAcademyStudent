require_relative "00_tree_node/lib/00_tree_node.rb"

class KnightPathFinder
  attr_accessor :visited_positions, :move_tree
  POSSIBLE_MOVES = [
    [2, 1],
    [2, -1],
    [1, 2],
    [1, -2],
    [-2, 1],
    [-2,-1],
    [-1, 2],
    [-1, -2]
  ]

  def initialize(start)
    @visited_positions = [start]
    @move_tree = build_move_tree(start)
  end

  def build_move_tree(start) # using breadth-first
    root = PolyTreeNode.new(start)
    queue = [root]
    until queue.empty?
      current_node = queue.shift
      # p current_node.value
      valid_moves = new_move_positions(current_node.value)
      valid_moves.each { |vm| current_node.add_child(PolyTreeNode.new(vm)) }
      queue += current_node.children
    end
    root
  end

  def new_move_positions(pos)
    valid_moves = KnightPathFinder.valid_moves(pos)
    valid_moves.select! { |vm| !visited_positions.include?(vm) }
    @visited_positions += valid_moves
    valid_moves
  end

  def self.valid_moves(pos)
    a, b = pos
    possible_moves = POSSIBLE_MOVES.map { |x, y| [a + x, y + b] }
    possible_moves.select { |a, b| a.between?(0, 7) && b.between?(0, 7) }
  end

  def find_path(end_pos)
    found_node = find_path_dfs(end_pos, move_tree)
    trace_path_back(found_node)
  end

  def find_path_dfs(end_pos, node)
    return node if node.value == end_pos
    node.children.each do |child|
      found_node = find_path_dfs(end_pos, child)
      return found_node unless found_node.nil?
    end
    nil
  end

  def trace_path_back(node)
    return [node.value] if node.parent.nil?
    trace_path_back(node.parent) + [node.value]
  end
end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([2, 1])
p kpf.find_path([3, 3])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
