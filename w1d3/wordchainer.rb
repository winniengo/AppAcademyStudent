require 'set'

class WordChainer
  attr_reader :dictionary
  attr_accessor :current_words, :all_seen_words

  ALPHABET = ("a".."z").to_a

  def initialize(dictionary_file_name)
    @dictionary = read_dictionary(dictionary_file_name)
  end

  def read_dictionary(filename)
    local_set = Set.new
    File.foreach(filename) do |line|
      local_set << line.chomp
    end
    local_set
  end

  def adjacent_words(word)
    adjacent_words = Set.new
    word.each_char.with_index do |_, i|
      mutant = word.dup
      ALPHABET.each do |letter|
        mutant[i] = letter
        adjacent_words << mutant if @dictionary.include?(mutant)
      end
    end
    adjacent_words
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }
    explore_current_words until @all_seen_words.include?(target)
    path = build_path(target)
    display_result(path)
  end

  def explore_current_words
    until @current_words.empty?
      new_current_words = []
      @current_words.each do |current_word|
        self.adjacent_words(current_word).each do |adjacent_word|
          unless @all_seen_words.include?(adjacent_word)
            new_current_words << adjacent_word
            @all_seen_words[adjacent_word] = current_word
          end
        end
        # display_new_current_words(new_current_words)
      end
      @current_words = new_current_words
    end
  end

  def display_new_current_words(new_current_words)
    new_current_words.each do |current_word|
      puts "#{current_word}: #{all_seen_words[current_word]}"
    end
  end

  def build_path(target)
    return [target] if @all_seen_words[target].nil?
    build_path(@all_seen_words[target]) + [target]
  end

  def display_result(path)
    puts "Building chain..."
    path.each { |word| puts word }
  end
end

wc = WordChainer.new('dictionary.txt')
wc.run("cat", "tot")
