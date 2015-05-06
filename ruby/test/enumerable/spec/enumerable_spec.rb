require 'spec_helper'

describe Enumerable do
  describe '#my_each' do
    it "should iterate a range and yield to a block" do
      arr = []
      (1..5).my_each {|int| arr << int}
      expect(arr).to eq [1,2,3,4,5]
    end
  end

  describe '#my_each_with_index' do
    it "should return the value and index for each element" do
      arr = ['hello', 'world']
      result = []
      arr.my_each_with_index {|e,i| result << "#{i} element is #{e}"} 
      expect(result).to eq ['0 element is hello', '1 element is world']
    end
  end

  describe '#my_select' do
    it 'selects specific values correctly from an array' do
      arr = [1,2,3,4,5]
      result = arr.my_select {|x| x.odd?}
      expect(result).to contain_exactly(1,3,5)
    end
  end

  describe '#my_any?' do
    it 'should return true for a matching value' do
      result = (1..5).my_any? {|x| x == 3 }
      expect(result).to be true
    end
    it 'should return false for no matching value' do
      result = (1..5).my_any? {|x| x == 10}
      expect(result).to be false
    end
  end

  describe '#my_map' do
    it 'should map a proc on each element of an array' do
      arr = [1,2,3,4,5]
      result = arr.my_map {|x| x + 1}
      expect(result).to contain_exactly(2,3,4,5,6)
    end
  end

  describe '#my_inject' do
    it 'should use a given block to combine all elements in an array' do
      arr = [1,2,3,4,5]
      block = Proc.new {|tot, val| tot += val}
      result = arr.my_inject(&block)
      expect(result).to eq 15
    end
  end
end
