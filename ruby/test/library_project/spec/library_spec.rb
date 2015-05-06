require 'spec_helper.rb'

describe Library do

  before :all do
    lib_arr = [
      Book.new("Money Talks, Bullshit Walks", "Sammy", :cool),
      Book.new("The Singularity is Near", "Kurzwiel", :futurist),
      Book.new("People are stupid and so am I", "Me", :cool)
    ]

    File.open "books.yml", "w" do |f|
      f.write YAML::dump lib_arr
    end

  end
  before :each do
    @lib = Library.new 'books.yml'
  end

  describe "#new" do 
    context "with no parameters" do
      it "should have no books" do
        lib = Library.new
        expect(lib.books.length).to eq 0
      end
    end
    context "with parameters" do
      it "has 3 books" do
        expect(@lib.books.length).to eq 3
      end
    end
  end
  
  it "returns all given books in a category" do
    expect(@lib.get_books_in_category(:cool).length).to eq 2
  end
  
  it 'accepts new books' do
    expect{@lib.add_book(Book.new('New Book', 'Mlem', :futurist))}.to change {@lib.books.length}.by 1
  end
  
  it 'allows searching for books by title' do
    expect(@lib.find_book('The Singularity is Near')).to be_an_instance_of Book
  end
  
  it 'saves itself to file' do
    book = Book.new('Saved Book', 'Chewie', :testing)
    lib = @lib.dup
    lib.add_book(book)
    lib.save
    lib_after_save = YAML.load(File.read('booksave.yml'))
    expect(lib_after_save.length).to eq 4
  end
end
