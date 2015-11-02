class Array
  def my_inject(accumulator = nil, &block)
    i = 0

    if accumulator.nil?
      accumulator = self.first
      i += 1
    end

    while i < self.length
      accumulator = block.call(accumulator, self[i])
      i += 1
    end
    accumulator
  end
end

def is_prime?(num)
  (2...num).none? { |factor| num % factor == 0 }
end

def primes(count)
  primes = []

  n = 2
  until primes.length == count
    primes << n if primes.all? { |prime| n % prime > 0 }
    n += 1
  end 
  primes
end

# the "calls itself recursively" spec may say that there is no method
# named "and_call_original" if you are using an older version of
# rspec. You may ignore this failure.
# Also, be aware that the first factorial number is 0!, which is defined
# to equal 1. So the 2nd factorial is 1!, the 3rd factorial is 2!, etc.
def factorials_rec(num)
  return [1] if num == 1 
  
  factorial = 1
  (2...num).each do |n|
    factorial *= n
  end
  factorials_rec(num - 1) << factorial
end

class Array
  def dups
    dups_hash = Hash.new { Array.new } 

    self.each_with_index do |el, i|
      dups_hash[el]  = dups_hash[el] << i
    end
    dups_hash.select { |key, value| value.count > 1}
  end
end

class String
  def symmetric_substrings
    symm_subs = []

    self.length.times do |start|
      (2..(self.length - start)).each do |len|
        sub = self[start...(start + len)]
        symm_subs << sub if sub == sub.reverse
      end
    end
    symm_subs
  end
end

class Array
  def merge_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    return self if length <= 1

    Array.merge(
      self.take(self.length / 2).merge_sort(&prc),
      self.drop(self.length / 2).merge_sort(&prc),
      &prc
    )
  end

  private
  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when -1
        merged << left.shift
      when 0
        merged << left.shift
      when 1
        merged << right.shift
      end
    end

    merged += left
    merged += right 

    merged
  end
end
