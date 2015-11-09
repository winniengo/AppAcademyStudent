ALPHABET = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a + " ./<>?;:\"'`!@#$%^&*()[]{}_+=|\\-".split("")

class String
  def hash
    hashed = [1]
    self.each_char do |chr|
      hash_key = ALPHABET.index(chr)
      hashed << hash_key
    end
    hashed.map! { |key| key < 10 ? "0#{key}" : "#{key}"}
    hashed.join("").to_i ^ 1010_1010_1010_1010
  end

  # def dehash(hashed)
  #   original_message = ""
  #   temp = (hashed ^ 1010_1010_1010_1010).to_s.split("").drop(1)
  #   # p temp
  #   i = 0
  #   while i < temp.size
  #     original_message << ALPHABET[temp[i..i + 1].join.to_i]
  #     i += 2
  #   end
  #   # p original_message
  #   original_message
  # end
end

class Array
  def hash
    hashed = ""
    return nil if empty?
    self.each do |el|
      hashed += el.hash.to_s
    end
    hashed.to_i
  end
end



# class Hash
#   def hash
#   end
# end

# p 2.hash
# p 2.hash
# p 2.hash
# p 2.hash
# p 2.hash
# p [1,2,3,4].hash
# p [1,2,3,4].hash
# p [1,2,3,4].hash
# p [4,3,2,1].hash
# p [4,3,2,1].hash
# p ["hey", 3, 2, 1].hash
# p ["hey", 3, 2, 1].hash
# p [4,3,2,1].hash
# hashed = "hello".hash
# p "hello".hash
# p "hello".hash
# p hashed
# "".dehash(hashed)
