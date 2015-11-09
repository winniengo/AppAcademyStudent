class MyStack
  attr_accessor :store, :min_stack, :max_stack

  def initialize
    @store = []
    @min_stack = []
    @max_stack = []
  end

  def pop
    raise "stack is empty" if empty?
    min_stack.pop
    max_stack.pop
    store.pop
  end

  def push(item, min = @min_stack.last, max = @max_stack.last)
    store.push(item)
    if min.nil?
      min_stack.push(item)
      max_stack.push(item)
    else
      item > max ? @max_stack.push(item) : @max_stack.push(max)
      item < min ? @min_stack.push(item) : @min_stack.push(min)
    end
  end

  def peek
    store.last
  end

  def size
    store.size
  end

  def empty?
    store.empty?
  end

  def max
    @max_stack.last
  end

  def min
    @min_stack.last
  end

  def to_s
    @store.join(", ")
  end
end

# stack = MyStack.new
# stack.push(10)
# stack.push(8)
# stack.push(15)
# puts stack
# p stack.max
# p stack.min
# stack.pop
# stack.pop
# p stack.max
# p stack.min

class StackQueue
  def initialize
    @in_stack = MyStack.new
    @out_stack = MyStack.new
  end

  def enqueue(item)
    if @out_stack.empty?
      @in_stack.push(item)
    else
      @in_stack.push(item, @out_stack.min, @out_stack.max)
    end

  end

  def dequeue
    raise "queue is empty" if self.empty?

    if @out_stack.empty?
      until @in_stack.empty?
        @out_stack.push(@in_stack.pop)
      end
    end
    @out_stack.pop
  end

  def size
    @in_stack.size + @out_stack.size
  end

  def empty?
    @in_stack.empty? && @out_stack.empty?
  end

  def to_s
    p @in_stack
    p @out_stack
    # "#{@in_stack} | #{@out_stack}"
  end

  def max
    raise "queue is empty" if self.empty?
    @in_stack.empty? ? @out_stack.max : @in_stack.max
  end

  def min
    raise "queue is empty" if self.empty?
    @in_stack.empty? ? @out_stack.min : @in_stack.min
  end
end
#
# stack = StackQueue.new
# stack.enqueue(10)
# stack.enqueue(8)
# stack.enqueue(15)
# p stack.max
# p stack.min
# stack.dequeue
# puts stack
# # stack.dequeue
# stack.enqueue(20)
# puts stack
# p stack.max
# p stack.min
# p stack.dequeue
# p stack.max
# p stack.min
# stack.pop
# stack.pop
# p stack.max
# p stack.min
