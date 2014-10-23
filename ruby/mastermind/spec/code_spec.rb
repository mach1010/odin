require 'spec_helper'

# Mastermind
module Mastermind
  describe Code do
    let(:code) { Code.new(4) }

    it 'should create a new code object' do
      expect(code).to be_an_instance_of Code
    end
    it 'should return an array' do
      expect(code.code).to be_an Array
    end
    it 'should contain the number of elements requested' do
      expect(code.code.length).to eq 4
    end
    it 'should raise an exception if called without a value' do
      expect { Code.new }.to raise_exception
    end
  end
end
