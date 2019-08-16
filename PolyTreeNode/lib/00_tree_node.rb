class PolyTreeNode
  
  attr_accessor :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = [] 
  end 

  def parent=(passed_parent)
    if @parent != nil
      @parent.children.delete(self)
    end
    @parent = passed_parent
    if passed_parent != nil
      if !(passed_parent.children.include?(self))
        passed_parent.children << self
      end
    end
  end
  
  def add_child(child) 
    @children << child
    child.parent = self
  end 

  def remove_child(child)
    if !@children.include?(child)
      raise "Error: Not a child."
    end
    child.parent = nil 
    @children.pop(0)
  end 

  def dfs(target)
    found = nil
    if self.value == target
      return self
    end
    if self.children.length < 1
      nil
    else
      self.children.each do |child|
        if found == nil
          found = child.dfs(target)
        end
      end
    end
    found
  end

  def bfs(target)
    queue = []
    queue << self 
    while queue.length > 0
      if queue[0].value == target
        return queue[0]
      else
        if queue[0].children.length > 0
          queue += queue[0].children
        end
        queue.shift
      end
    end
    nil
  end   
end