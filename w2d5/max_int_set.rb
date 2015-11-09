class MaxIntSet

  def initialize(max)
    @store = Array.new(max) {false}
  end

  def insert(int)
    raise "#{int} not in range" unless int.between?(0, @store.length)
    @store[int] = true
  end

  def remove(int)
    raise "#{int} not in range" unless int.between?(0, @store.length)
    @store[int] = false
  end

  def include?(int)
    raise "#{int} not in range" unless int.between?(0, @store.length)
    @store[int]
  end

end

# maxintset = MaxIntSet.new(9)
#
#  maxintset.insert(5)
#  maxintset.insert(4)
# p maxintset.include?(4)
#  maxintset.insert(3)
#  maxintset.remove(4)
# p maxintset.include?(4)
# maxintset.insert(20)
