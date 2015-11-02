class Array
  # Write a method that binary searches an array for a target and returns its
  # index if found. Assume a sorted array
  def binary_search(target)
    return nil if self.empty? || (self.length == 1 && self.first != target)
    return 0 if self.length == 1 # self.first == target

    mid = self.length / 2
    if self[mid] > target # look at lower half
      self.take(mid).binary_search(target)
    elsif self[mid] == target
      return mid
    else # self[mid] < target, look at upper half
      sub_return = self.drop(mid).binary_search(target)
      sub_return.nil? ? nil : mid + sub_return
    end
  end
end

class Array
  # Write a new `Array#pair_sum(target)` method that finds all pairs of
  # positions where the elements at those positions sum to the target.

  # NB: ordering matters. I want each of the pairs to be sorted
  # smaller index before bigger index. I want the array of pairs to be
  # sorted "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def pair_sum(target)
    pairs = []
    self.each_index do |i|
      (i...length).each do |j|
        pairs << [i, j] if self[i] + self[j] == target && i != j
      end
    end 
    pairs
  end
end

# write a method called 'sum_rec' that
# recursively calculates the sum of an array of values
def sum_rec(nums)
  return 0 if nums.empty?
  nums.first + sum_rec(nums.drop(1))
end

class String
  # Write a `String#symmetric_substrings` method that takes a returns
  # substrings which are equal to their reverse image ("abba" ==
  # "abba"). We should only include substrings of length > 1.

  def symmetric_substrings
    symm_subs = []
    self.each_char.with_index do |_, i|
      (i..length).each do |j|
        symm_subs << self[i, j] if self[i, j] == self[i, j].reverse && j - i > 1
      end
    end
    symm_subs.uniq
  end
end

# def is_prime?(num)
# end

# Write a method that returns the nth prime number
def nth_prime(n)
  primes = []
  i = 2
  until primes.length == n
    primes << i if primes.all? { |p| i % p > 0 } # primes aren't divisible by any primes
    i += 1
  end
  primes.last
end

class Array
  # Write a method that calls a passed block for each element of the array
  def my_each(&prc)
    self.length.times do |i|
      prc.call(self[i])
    end
    self
  end
end

