class LinkedList
  include Enumerable

  attr_reader :tail, :head
  def initialize
    @head = nil
    @tail = nil
    # @size = 0
  end

  def insert(key, val)
    new_node = LinkedListNode.new(key, val)
    if empty?
      @head = new_node
      @tail = new_node
    else
      new_node.prev = @tail
      @tail.next = new_node
      @tail = new_node
    end
  end

  def remove(key)
    if @head == @tail && @head.key == key
      @head = nil
      @tail = nil
      return
    end

    if @head.key == key
      @head = @head.next
      @head.prev = nil
      return
    end

    current_node = @head
    until current_node.next == nil
      current_node = current_node.next
      if current_node == @tail && current_node.key == key
        current_node.prev.next = nil
        @tail = current_node.prev
        return
      elsif current_node.key == key
        current_node.prev.next = current_node.next
        current_node.next.prev = current_node.prev
        return
      end
    end
  end

  def empty?
    @head.nil?
  end

  def first
    @head
  end

  def get(key)
    return nil if @head == nil
    return @head.value if @head.key == key

    current_node = @head
    until current_node.next == nil
      current_node = current_node.next
      return current_node.value if current_node.key == key
    end
    nil
  end

  def include?(key)
    get(key).nil? ? false : true
  end

  def each(&prc)
    return self if self.empty?

    current_node = @head
    until current_node.next == nil
      prc.call(current_node)
      current_node = current_node.next
    end

    prc.call(current_node)
    self
  end


  def to_s
    return "[ ]" if self.empty?

    output = "[#{@head}"
    current_node = @head

    until current_node.next == nil
      current_node = current_node.next
      output << ", #{current_node}"
    end
    output << "]"
  end
end


class LinkedListNode

  attr_accessor :prev, :next, :key, :value

  def initialize(key, value)
    @prev = nil
    @next = nil
    @key = key
    @value = value
  end

  def to_s
    "#{@key}: #{@value}"
  end
end

#
# ll = LinkedList.new
# ll.insert(5, 4)
# ll.insert(20, 1)
# ll.insert(8, 10)
# ll.insert(19, 92)
# p ll.include?(20)
# p ll.include?(19)
# # # puts ll
# # # p ll.include?(5)
# # # p ll.include?(0)
# # # puts ll
# # ll.remove(19)
# # # puts ll.tail
# # # puts ll
# # ll.remove(20)
# # # puts ll
# # # puts ll.head
# # # puts ll.tail
# #
# #
# # ll .remove(5)
# # # puts ll
# # # puts ll.head
# #
# # ll.remove(8)
# # puts ll
#
# ll.each { |node| node.value += 1 }
# puts ll
# puts ll.map { |node| node.value = 5 }
