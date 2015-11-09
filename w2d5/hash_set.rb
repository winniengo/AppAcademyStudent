require_relative 'hash'

class HashSet
  attr_reader :store

  def initialize
    @store = Array.new(4) { Array.new }
    @size = 0
  end

  def insert(item)
    idx = item.hash % @store.length
    unless @store[idx].include?(item)
      if @size + 1 == @store.length
        resize
        idx = item.hash % @store.length
      end
      @store[idx] << item
      @size += 1
    end
  end

  def remove(item)
    idx = item.hash % @store.length
    if @store[idx].include?(item)
      @store[idx].delete(item)
      @size -= 1
    end
  end

  def include?(item)
    idx = item.hash % @store.length
    @store[idx].include?(item)
  end

  def resize
    temp_store = Array.new(@store.length * 2) { Array.new }
    @store.each do |subarray|
      subarray.each do |el|
        idx = el.hash % temp_store.length
        temp_store[idx] << el
      end
    end
    @store = temp_store
  end
end
# 
# test = HashSet.new
# test.insert(0)
# test.insert(20)
# test.insert(2)
# # p test.store
# # test.insert(5)
# # test.insert(10)
# # # p test.store
# # test.remove(10)
# # # p test.store
# # 100.times do |i|
# #   test.insert("#{i}")
# # end
# test.insert([1,2,3,4,5])
# test.insert([5,4,3,2,1])
# p test.store
