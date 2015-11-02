class Array
	def my_each(&prc)
		self.length.times do |i|
			prc.call(self[i])
		end
		self
	end

	def my_select(&prc)
		selected = []
		self.my_each do |el|
			selected << el if prc.call(item)
		end
		selected
	end

	def my_reject(&prc)
		rejected = []
		self.my_each do |el|
			rejected << el unless prc.call(el)
		end
		rejected
	end

	def my_any?(&prc)
		self.my_each do |el|
			return true if prc.call(el)
		end
		false
	end

	def my_all?(&prc)
		self.my_each do |el|
			return false unless prc.call(el)
		end
		true
	end

	def my_flatten
		flattened = []

		self.my_each do |el|
			if el.is_a?(Array)
				flattened += el.my_flatten
			else
				flattened << el
			end
		end
		flattened
	end

	def my_zip(*arrs)
		zipped = []
		self.length.times do |i|
			subzipped = [self[i]]
			arrs.each do |arr| 
				subzipped << arr[i]
			end
			zipped << subzipped
		end
		zipped
	end

	def my_rotate(n=0)
		rotated = []
		self.length.times do |i|
			rotated << self[ (n + i) % self.length]
		end
		rotated
	end

	def my_join(sym="")
		joined = ""
		self.my_each do |el|
			joined << el
			joined << sym
		end

		joined[0..-2]
	end

	def my_reverse
		reversed = []
		self.my_each do |el|
			reversed.unshift(el)
		end
		reversed
	end
end

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten
# a = [ 4, 5, 6 ]
# # b = [ 7, 8, 9 ]
# # p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# # p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# # p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# # c = [10, 11, 12]
# # d = [13, 14, 15]
# # p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]
# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

# p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# p [ 1 ].my_reverse               #=> [1]