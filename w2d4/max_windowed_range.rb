require_relative 'stack'

def windowed_max_range(arr, w) # O(n^2)
  i = 0
  current_max_range = 0
  while i <= arr.length - w
    j = i + 1
    min = arr[i]
    max = arr[i]
    while j < i + w
      min = arr[j] if arr[j] < min
      max = arr[j] if arr[j] > max
      j += 1
    end
    range = max - min
    current_max_range = range if range > current_max_range
    i += 1
  end
  current_max_range
end

def opt_windowed_max_range(arr, w)
  current_max_range = 0

  i = 0
  while i < arr.length - w # n - w
    j = i + 1
    min_max_stack_queue = StackQueue.new
    until min_max_stack_queue.size == w # w
      min_max_stack_queue.enqueue(arr[j])
      j += 1
    end
    current_range = min_max_stack_queue.max - min_max_stack_queue.min
    current_max_range = current_range if current_range > current_max_range
    i += 1
  end
  current_max_range
end

#
# p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8


p opt_windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p opt_windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p opt_windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p opt_windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
