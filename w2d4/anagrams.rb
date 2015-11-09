def anagram1?(first, second) # TODO how to write permutation method
  first_arr = first.split("")
  permutations = first_arr.permutation.to_a # O(n!)
  permutations.any? {|perm| perm.join("") == second } # O(n)
end

def anagram2?(first, second)
  return false unless first.length == second.length
  same_letters = 0
  first.each_char do |chr1|
    second.each_char do |chr2|
      if chr2 == chr1
        same_letters += 1
        break
      end
    end
  end

  same_letters == first.length
end

def anagram3?(first, second)
  first.split("").sort == second.split("").sort
end

def anagram4?(first, second)
  first_hash = Hash.new { 0 }
  second_hash = Hash.new { 0 }

  first.length.times do |i|
    first_hash[first[i]] += 1
    second_hash[second[i]] += 1
  end

  first_hash == second_hash
end


p anagram4?("gizmo", "sally")    #=> false
p anagram4?("elvis", "lives")    #=> true
