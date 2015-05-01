require './00_tree_node.rb'

class KnightPathFinder
  POSSIBLE_MOVES = [[1, 2], [-1, 2], [1, -2], [-1, -2],
                    [2, 1], [-2, 1], [2, -1], [-2, -1]]

  def initialize(start)
    @start = start
    @start_node = PolyTreeNode.new(start)
    @visited_positions = [start]
    build_move_tree
  end

  def build_move_tree
    current_nodes = [@start_node]

    until current_nodes.empty?
      new_nodes = []
      current_nodes.each do |node|
        new_moves = new_move_positions(node.value)

        new_moves.each do |move|
          child_node = PolyTreeNode.new(move)
          child_node.parent = node
          new_nodes << child_node
        end
      end

      current_nodes = new_nodes
    end
  end

  def self.valid_moves(pos)
    valid_moves = POSSIBLE_MOVES.map do |move|
      [pos[0] + move[0], pos[1] + move[1]]
    end

    valid_moves.select do |move|
      on_board?(move)
    end
  end

  def new_move_positions(pos)
    possible_moves = KnightPathFinder.valid_moves(pos)
    possible_moves.select! { |move| !@visited_positions.include?(move) }
    @visited_positions += possible_moves
    possible_moves
  end

  def find_path(end_pos)
    end_node = @start_node.bfs(end_pos)
    end_node.trace_path_back
  end

  private

  def self.on_board?(pos)
    pos[0] <= 7 && pos[0] >= 0 && pos[1] <= 7 && pos[1] >= 0
  end
end

knight = KnightPathFinder.new([0,0])
p knight.find_path([7,6])
p knight.find_path([6,2])
