require 'yaml'

class Library
  attr_accessor :books
  
  def initialize lib_file=false
    @lib_file = lib_file
    @books = @lib_file ? YAML::load(File.read(@lib_file)) : []
  end
  
  def get_books_in_category(category)
    @books.select {|book| book.category == category}
  end
  
  def add_book(book)
    @books << book
  end
  
  def find_book(title)
    @books.select {|book| book.title == title}.first
  end
  
  def save
    File.open('booksave.yml', 'w') { |f| f.write(YAML.dump(@books))}
  end
end