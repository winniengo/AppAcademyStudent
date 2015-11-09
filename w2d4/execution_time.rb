def my_min(arr)
  arr.each do |el|
    n_greater_than = 0
    arr.each do |el2|
      n_greater_than += 1 if el <= el2
    end
    return el if n_greater_than == arr.length
  end
end

def my_min_2(arr)
  min = arr.first
  arr.each do |el|
    min = el if el < min
  end
  min
end

# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# p my_min(list)  # =>  -5
# p my_min_2(list)  # =>  -5

def largest_subsum(arr)
  largest_sum = arr.first
  arr.each_with_index do |el, i|
    curr_sum = 0
    (i...arr.length).each do |j|
      curr_sum += arr[j]
      largest_sum = curr_sum if curr_sum >= largest_sum
    end
  end
  largest_sum
end

def largest_subsum2(arr) # TODO fix is arr is all negatives
  largest_sum = 0
  curr_sum = 0
  arr.each do |el|
    curr_sum += el
    largest_sum = curr_sum if curr_sum > largest_sum
    curr_sum = 0 if curr_sum < 0
  end
  largest_sum
end

# list = [5, 3, -7]
# p largest_subsum2(list) # => 8
#
# list2 = [5, 3, -7, 8, 9]
# p largest_subsum2(list2) # => 18
#
# list3 = [3, 8, -12, 10]
# p largest_subsum2(list3)
