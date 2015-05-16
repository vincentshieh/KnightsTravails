class PolyTreeNode
  attr_accessor :children
  attr_reader :parent, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def add_child(child_node)
    @children << child_node
    child_node.parent = self
  end

  def bfs(target_value)
    node_queue = [self]
    until node_queue.empty?
      node = node_queue.shift
      return node if target_value == node.value
      node.children.each do |child|
        node_queue << child
      end
    end
  end

  def dfs(target_value)
    return self if target_value == @value

    @children.each do |child|
      child_search = child.dfs(target_value)
      return child_search if child_search
    end

    nil
  end

  def parent=(parent)
    @parent.children.delete(self) unless @parent.nil?
    @parent = parent
    unless @parent.nil? || @parent.children.include?(self)
      @parent.children << self
    end
  end

  def remove_child(child)
    raise "No such child" unless @children.include?(child)
    @children.delete(child)
    child.parent = nil
  end

  def trace_path_back
    return [value] if @parent.nil?
    @parent.trace_path_back << value
  end
end
