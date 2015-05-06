require 'spec_helper'

describe Book do
  
  before :each do # can use :all
    @book = Book.new "Title", "Author", :category
  end
  
  describe "#new" do # using the method name so the output would return Book#new
    it "returns a new book object" do
      expect(@book).to be_instance_of Book
    end
    
    it "should throw error with less than 3 arguments" do
      expect {book = Book.new "Title", "Author"}.to raise_error ArgumentError
    end
  end
  
  describe "#title" do
    it "should return title" do
      # .to eq, .to eql and .equal? is ==; .to equal is ===
      expect(@book.title).to eq "Title" 
    end
  end
  
  describe "#author" do
    it "should return author" do
      expect(@book.author).to eq "Author" 
    end
  end
    
  describe "#category" do
    it "should return category" do
      expect(@book.category).to eq :category 
    end
  end
  
end