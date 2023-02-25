module BooksHelper
  def find_book_name(id)
    @book = Book.find(id)
    @book.name
  end
end
