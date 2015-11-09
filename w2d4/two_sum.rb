def bad_two_sum?(arr, target_sum)
  arr.each_with_index do |el1, idx|
    arr.drop(idx + 1).each do |el2|
      return true if el1 + el2 == target_sum
    end
  end
  false
end

# worst-case O(n^2)

def okay_two_sum?(arr, target_sum)
  sorted_arr = arr.sort # O(nlogn)

  until arr.empty? do # O(n)
    el = arr.shift
    return true if binary_search(arr, target_sum - el)
  end

  false
end

# worst-case O(n*logn)

def binary_search(arr, target) # O(logn)
  return false if arr.empty?

  mid_idx = arr.length / 2
  mid_el = arr[mid_idx]
  if target == mid_el
    true
  elsif mid_el > target
    binary_search(arr.drop(mid_idx))
  else
    binary_search(arr.take(mid_idx))
  end
end

def two_sum?(arr, target)
  arr_hash = Hash.new { 0 } # O(n)

  arr.each do |el| # O(n)
    arr_hash[el] += 1 # O(1)
  end

  arr.each do |el| # O(n)
    arr_hash[el] -= 1
    return true if arr_hash[target - el] > 0 # O(1)
  end

  false
end

arr = [1, 1, 5, 7]
p two_sum?(arr, 6) # => should be true
p two_sum?(arr, 10) # => should be false

arr2 = [0, 2, 2, 10, 12]
p two_sum?(arr2, 14)

arr3 = [2]
p two_sum?(arr3, 4)

def four_sum?(arr, target)
  # arr_hash = create_hash_map(arr)

  arr.each do |el| # O(n)
    arr.shift
    return true if four_sum_helper?(arr, target - el)
  end
  #
  #   arr_hash[el] -= 1
  #   return true if arr_hash[target - el] > 0 # O(1)
  # end
  false
end

def create_hash_map(arr) # O(n)
  arr_hash = Hash.new { 0 } # O(n)

  arr.each do |el| # O(n) - laod hash map
    arr_hash[el] += 1 # O(1)
  end

  arr_hash
end

def four_sum_helper?(arr, target)
  arr.each do |el|
    arr.shift
    return true if four_sum_helper?(arr, target - el)
  end
end

arr4 = [1, 1, 5, 6, 2]
p four_sum?(arr4, 10)
