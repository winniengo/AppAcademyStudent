require_relative 'hash'
require_relative 'linked_list'

class HashMap
  attr_reader :store

  def initialize
    @store = Array.new(4) { LinkedList.new }
    @size = 0
  end

  def insert(key, value)
    idx = key.hash % @store.length
    unless @store[idx].include?(key)
      if @size + 1 == @store.length
        resize
        idx = key.hash % @store.length
      end
      @store[idx].insert(key, value)
      @size += 1
    end
  end

  def remove(key)
    idx = key.hash % @store.length
    if @store[idx].include?(key)
      @store[idx].remove(key)
      @size -= 1
    end
  end

  def include?(key)
    idx = key.hash % @store.length
    @store[idx].include?(key)
  end

  def get(key)
    idx = key.hash % @store.length
    puts @store[idx]
    @store[idx].get(key) unless @store[idx].nil?
  end

  def resize
    temp_store = Array.new(@store.length * 2) { LinkedList.new }
    @store.each do |linkedlist|
      linkedlist.each do |node|
        idx = node.key.hash % temp_store.length
        temp_store[idx].insert(node.key, node.value)
      end
    end
    @store = temp_store
  end
end

# test = HashMap.new
# test.insert(8, 8)
# test.insert(20, 10)
# test.insert(2, 0)
# # puts test.store
# test.insert(5, 100)
# test.insert(10, 0)
# puts test.store
# test.remove(10)
# # p test.store
# 100.times do |i|
#   test.insert("#{i}")
# end
# test.insert([1,2,3,4,5])
# test.insert([5,4,3,2,1])
# p test.store
