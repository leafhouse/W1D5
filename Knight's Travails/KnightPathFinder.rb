require_relative "../PolyTreeNode/lib/00_tree_node.rb"

class KnightPathFinder
  def initialize(starting_pos)
    @starting_pos = starting_pos
    @root_node = PolyTreeNode.new(starting_pos)
    @considered_positions = [starting_pos]
    #self.build_move_tree
  end

  def build_move_tree(target)
    movetree = []
    moves = new_move_position(@starting_pos)
    queue = []
    moves.each do |move|
      @root_node.add_child(newnode)
      queue << newnode
    end
    while queue.length > 0
      if queue[0].value == target
        return queue[0].value
      else
        @considered_positions << queue[0]
        if self.new_move_position(queue[0]).length > 0
          self.new_move_position(queue[0]).each do |move|
            queue << PolyTreeNode.new(move)
          end
        end
        queue.shift
      end
    end
  end

  def self.valid_moves(pos)
    x,y = pos[0],pos[1]
    possible_next_pos = [
      [x-2, y-1],
      [x-1, y-2],
      [x-2, y+1],
      [x-2, y+2],
      [x+1, y-1],
      [x+2, y-1],
      [x+2, y+1],
      [x+1, y+2]
    ]
    available_moves = possible_next_pos.select { |pos_n| pos_n[0].between?(0,7) && pos_n[1].between?(0,7) }   
  end

  def new_move_position(pos)
    moves = KnightPathFinder.valid_moves(pos).select { |move| !@considered_positions.include?(move) }
  end 
  


end

k = KnightPathFinder.new([4,4])
p KnightPathFinder.valid_moves([7,7])