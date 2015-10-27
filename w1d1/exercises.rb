class Array
  def my_each(&blk)
    i = 0
    while i < self.length
      blk.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&blk)
    ret = []
    prc = proc { |el| ret << el if blk.call(el) }
    self.my_each(&prc)
    ret
  end

  def my_reject(&blk)
    self - self.my_select(&blk)
  end

  def my_any?(&blk)
    self.my_each { |el| return true if blk.call(el) }
    false
  end

  def my_all?(&blk)
    self.my_each { |el| return false unless blk.call(el) }
    true
  end

  def my_flatten
    ret = []
    self.each do |el|
      if el.is_a?(Fixnum)
        ret << el
      elsif el.is_a?(Array)
        ret += el.my_flatten
      end
    end
    ret
  end

  def my_zip(*args)
    ret = Array.new(self.length) { Array.new }
    self.each_with_index do |el, idx|
      ret[idx] << el
      args.each do |arr|
        ret[idx] << arr[idx]
      end
    end
    ret
  end

  def my_rotate(x=1)
    ret = []
    i = 0
    while i < self.length
      ret[i] = self[(i + x) % self.length]
      i += 1
    end
    ret
  end

  def my_join(sep="")
    ret = ""
    self.each { |el| ret += el + sep}
    sep == "" ? ret : ret[0..-2]
  end

  def my_reverse
    ret = []
    i = self.length - 1
    while i >= 0
      ret << self[i]
      i -= 1
    end
    ret
  end
end

a = [1, 2, 3]
prc = proc { |num| puts num }
#puts [1, 2, 3].my_each(&prc)

prc2 = proc { |num| num > 1 }
#puts [1, 2, 3].my_select(&prc2)
#puts a.my_reject(&prc2)
#puts a.my_any? { |num| num > 1 }
#puts a.my_any? { |num| num == 4 }
#puts a.my_all? { |num| num > 1 }
#puts a.my_all? { |num| num < 4 }

#p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten
a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
#p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
#p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
#p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
#p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

a = [ "a", "b", "c", "d" ]
#p a.my_rotate         #=> ["b", "c", "d", "a"]
#p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
#p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
#p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

a = [ "a", "b", "c", "d" ]
#p a.my_join         # => "abcd"
#p a.my_join("$")    # => "a$b$c$d"

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
