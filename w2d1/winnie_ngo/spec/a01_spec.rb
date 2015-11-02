require 'rspec'
require 'spec_helper'
require 'a01'

describe '#binary_search' do
  # add a method to the Array class that performs a binary search for
  # an element and returns its index
  let(:arr) { [1, 2, 3, 4, 6] }

  it "returns nil if the array is empty" do
    expect([].binary_search(1)).to be_nil
  end

  it "returns the index of a target" do
    expect(arr.binary_search(3)).to eq(2)
  end

  it "returns the index of a target that's less than the midpoint" do
    expect(arr.binary_search(2)).to eq(1)
  end

  it "returns the index of a target that's greater than the midpoint" do
    expect(arr.binary_search(6)).to eq(4)
  end

  it "returns nil if the target isn't found" do
    expect(arr.binary_search(5)).to be_nil
  end

  it "does not call any blacklisted methods" do
    disallowed_methods = [
      :index, :find_index, :include?, :member?
    ]

    disallowed_methods.each do |method|
      expect(arr).not_to receive(method)
    end

    arr.binary_search(5)
    arr.binary_search(1)
  end

  it "doesn't index into the array more than necessary" do
    expect(arr).to receive(:[]).at_most(3).times.and_call_original

    arr.binary_search(3)
  end
end

describe "#pair_sum" do
  # Write a new `Array#pair_sum(target)` method that finds all pairs of
  # positions where the elements at those positions sum to the target.

  # NB: ordering matters. I want each of the pairs to be sorted
  # smaller index before bigger index. I want the array of pairs to be
  # sorted "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  it "returns positions of pairs of numbers that add to zero" do
    expect([5, 1, -7, -5].pair_sum(0)).to eq([[0, 3]])
  end

  it "returns positions of pairs that add to other targets" do
    expect([2, 1, 4, -2].pair_sum(5)).to eq([[1, 2]])
  end

  it "finds multiple pairs" do
    expect([5, -1, -5, 1].pair_sum(0)).to eq([[0, 2], [1, 3]])
  end

  it "finds pairs with same element" do
    expect([5, -5, -5].pair_sum(0)).to eq([[0, 1], [0, 2]])
  end

  it "returns [] when no pair is found" do
    expect([5, 5, 3, 1].pair_sum(7)).to eq([])
  end

  it "won't find spurious target pairs" do
    expect([0, 1, 2, 3].pair_sum(0)).to eq([])
  end
end

describe '#sum_rec' do
  # write a method called 'sum_rec' that
  # recursively calculates the sum of an array of values

  it "returns 0 if no values are given" do
    expect(sum_rec([])).to eq(0)
  end

  it "returns the first value if 1 value is given" do
    expect(sum_rec([1])).to eq(1)
  end

  it "calls itself recursively" do
    expect(self).to receive(:sum_rec).at_least(:twice).and_call_original
    sum_rec([1, 2, 3, 4])
  end

  it "sums multiple numbers" do
    expect(sum_rec([1, 2, 3, 4])).to eq(10)
  end

  it "sums multiple numbers II" do
    expect(sum_rec([-10, 10, 5, 4])).to eq(9)
  end
end

describe "#symmetric_substrings" do
  # Write a `String#symmetric_substrings` method that takes a returns
  # substrings which are equal to their reverse image ("abba" ==
  # "abba"). We should only include substrings of length > 1.

  it "handles a simple example" do
    expect("aba".symmetric_substrings).to match_array(["aba"])
  end

  it "handles two substrings" do
    expect("aba1cdc".symmetric_substrings).to match_array(["aba", "cdc"])
  end

  it "handles nested substrings" do
    expect("xabax".symmetric_substrings).to match_array(["aba", "xabax"])
  end
end

describe "#nth_prime" do
  # `nth_prime(n)` returns the nth prime number
  it "returns the first prime number" do
    expect(nth_prime(1)).to eq(2)
  end

  it "returns the fifth prime number" do
    expect(nth_prime(5)).to eq(11)
  end

  it "returns nil when asked for the zeroth prime" do
    expect(nth_prime(0)).to be_nil
  end
end

describe 'Array#my_each' do
  it 'calls the block passed to it' do
    expect do |block|
      ["test array"].my_each(&block)
    end.to yield_control.once
  end

  it 'yields each element to the block' do
    expect do |block|
      ["el1", "el2"].my_each(&block)
    end.to yield_successive_args("el1", "el2")
  end

  it 'does NOT call the Array#each method' do
    original_array = ["original array"]
    expect(original_array).not_to receive(:each)
    original_array.my_each {}
  end

  it 'is chainable and returns the original array' do
    original_array = ["original array"]
    expect(original_array.my_each {}).to eq(original_array)
  end
end

