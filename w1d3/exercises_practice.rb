def range(a, b)
	return [] if b < a
	[a] + range(a + 1, b)
end

# p range(0, 10)

def exp1(b, n)
	return 1 if n == 0
	b * exp1(b, n - 1)
end

def exp2(b, n)
	return 1 if n == 0
	return b if n == 1
	n.even? ? exp2(b, n / 2) ** 2 : b * exp2(b, (n - 1) / 2) ** 2
end

# p exp1(10, 3)
# p exp2(10, 3)

class Array
	def deep_dup
		return [] if self.empty?
		first = self.first
		first = first.deep_dup if first.is_a?(Array)
		[first] + self.drop(1).deep_dup
	end
end

# robot_parts = [
#   ["nuts", "bolts", "washers"],
#   ["capacitors", "resistors", "inductors"]
# ]
# robot_parts_copy = robot_parts.deep_dup
# robot_parts_copy[1] << "LEDs"
# p robot_parts
# p robot_parts_copy

# mixed_arr = [1, [2], [3, [4]]]
# mixed_arr_copy = mixed_arr.deep_dup
# p mixed_arr_copy

def bsearch(arr, target)
	return nil if arr.empty?

	mid = arr.length / 2
	case target <=> arr[mid]
	when -1
		bsearch(arr.take(mid), target)
	when 0
		mid
	when 1
		ans = bsearch(arr.drop(mid + 1), target)
		ans.nil? ? nil : mid + 1 + ans
	end
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

def make_change1(total, coins)
	return [] if coins.empty?

	n = total / coins.first
	[coins.first] * n + make_change1(total - (n * coins.first), coins.drop(1))
end

def make_change2(total, coins)
	return [] if total.zero?
	if total >= coins.first
		[coins.first] + make_change2(total - coins.first, coins)
	else 
		make_change2(total, coins.drop(1))
	end
end

def make_change3(total, coins)
	return [] if total.zero?
	best_sol = []
	pos_coins = coins.select { |c| c <= total }
	pos_coins.each do |coin|
		pos_sol = [coin] + make_change3(total - coin, pos_coins)
		if best_sol.empty?
			best_sol = pos_sol
		else
			best_sol = pos_sol if pos_sol.size < best_sol.size
		end
	end
	best_sol
end

# p make_change1(14, [10, 7, 1])
# p make_change2(14, [10, 7, 1])
# p make_change3(14, [10, 7, 1])

class Array
	def merge_sort
		return self if self.length < 2

		i = self.length / 2
		arr1 = self.take(i)
		arr2 = self.drop(i)
		sorted_arr1 = arr1.merge_sort
		sorted_arr2 = arr2.merge_sort

		merge(sorted_arr1, sorted_arr2)
	end

	def merge(left, right)
		merged = []
		until left.empty? || right.empty?
			if left.first < right.first
				merged << left.shift
			else
				merged << right.shift
			end
		end
		left.empty? ? (merged + right) : (merged + left)
	end
end

# p [5, 10, 2, 6, 3].merge_sort

def subsets(arr)
	return [arr] if arr.empty?
	element = arr.pop
  subset = subsets(arr)
  subset + subset.map { |sub_el| sub_el += [element] }
end

p subsets([]) # => [[]]
p subsets([1]) # => [[], [1]]
p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
p subsets([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]


