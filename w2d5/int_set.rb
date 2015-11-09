class IntSet

  attr_reader :store

  def initialize
    @store = Array.new(20) { Array.new }
  end

  def insert(item)
    idx = item % 20
    @store[idx] << item unless @store[idx].include?(item)
  end

  def remove(item)
    idx = item % 20
    @store[idx].delete(item)
  end

  def include?(item)
    idx = item % 20
    @store[idx].include?(item)
  end
end

# test = IntSet.new
# test.insert(4)
# test.insert(4)
# p test.store
# test.insert(100)
# test.insert(20)
# p test.store
# p test.include?(5)
# p test.include?(20)
# test.remove(20)
# test.remove(5)
# p test.store
