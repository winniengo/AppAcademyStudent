def range(min, max)
  return [] if max < min
  [min] + range(min + 1, max)
end

def sum(arr)
  sum = 0
  arr.each { |n| sum += n }
  sum
end

def sum_rec(arr)
  return arr.first if arr.size == 1
  arr.pop + sum_rec(arr)
end

# a = (1..5).to_a
#puts sum(a)
#puts sum_rec(a)

def exp1(base, n)
  return 1 if n == 0
  base * exp1(base, n - 1)
end

def exp2(base, n)
  return 1 if n == 0
  return base if n == 1

  if n.even?
    exp2(base, n / 2) ** 2
  else
    base * (exp2(base, (n - 1) / 2) ** 2)
  end
end

class Array
  def deep_dup
    return [] if self.empty?
    element = self.first
    if element.is_a?(Array)
      duped = [element.deep_dup]
    else
      duped = [element]
    end

    duped + self[1..-1].deep_dup
  end
end

# robot_parts = [
#   ["nuts", "bolts", "washers"],
#   ["capacitors", "resistors", "inductors"]
# ]
# duped = robot_parts.deep_dup
#p robot_parts[1].object_id
#p duped[1].object_id

def fib(n)
  return [1] if n == 1
  return [1, 1] if n == 2

  result = [1, 1]
  until result.size == n
    result << result[-1] + result[-2]
  end
  result
end

def fib_rec(n)
  return [1] if n == 1
  return [1, 1] if n == 2

  arr = fib_rec(n - 1)
  arr << (arr[-1] + arr[-2])
end

#p fib(5)
#p fib_rec(5)

def bsearch(arr, target)
  if arr.size == 1
    return arr.first == target ? 0 : nil
  end

  index = arr.size / 2
  if target < arr[index]
    bsearch(arr[0...index], target)
  else
    new_index = bsearch(arr[index..-1], target)
    new_index.nil? ? nil : index + new_index
  end
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

def make_change1(amount, coins)
  return [] if amount.zero?

  big_coin = coins.shift
  n = amount / big_coin
  new_amount = amount % big_coin
  ([big_coin] * n) + make_change(new_amount, coins)
end

 # p make_change(14, [10, 7, 1])

def make_change2(amount, coins)
  return [] if amount.zero?

  big_coin = coins.first
  if amount >= big_coin
    amount -= big_coin
    used_coin = [big_coin]
  else
    coins.shift
    used_coin = []
  end

  used_coin + make_change2(amount, coins)
end

# p make_change2(14, [10, 7, 1])
# p make_change2(10, [1])

def make_change3(amount, coins)
  return [] if amount.zero?

  best_sol = []
  pos_coins = coins.select { |c| c <= amount }
  pos_coins.each do |coin|
    new_amount = amount - coin
    pos_sol = [coin] + make_change3(new_amount, pos_coins)
    if best_sol.empty?
      best_sol = pos_sol
    else
      best_sol = pos_sol if best_sol.size > pos_sol.size
    end
  end
  best_sol
end

# p make_change3(14, [10, 7, 1])

def merge_sort(arr)
  return arr if arr.empty? || arr.size == 1

  idx = arr.size / 2
  arr1 = merge_sort(arr[0...idx])
  arr2 = merge_sort(arr[idx..-1])
  merge(arr1, arr2)
end

def merge(arr1, arr2)
  ret = []
  i = 0
  j = 0
  while i < arr1.size && j < arr2.size
    if arr1[i] < arr2[j]
      ret << arr1[i]
      i += 1
    else
      ret << arr2[j]
      j += 1
    end
  end

  ret += arr1[i..-1] if arr1.size > 0
  ret += arr2[j..-1] if arr2.size > 0

  ret
end

# p merge([], [1])
# p merge([1, 2, 5], [3, 4
# p merge_sort([1, 10, 2, 8, 7, 5])

def subsets(arr)
  return [arr] if arr.empty?

  element = arr.pop
  subset = subsets(arr)
  subset + subset.map { |sub_el| sub_el += [element] }
end

# p subsets([]) # => [[]]
# p subsets([1]) # => [[], [1]]
# p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# p subsets([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
