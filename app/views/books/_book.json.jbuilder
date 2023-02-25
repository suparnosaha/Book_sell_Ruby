json.extract! book, :id, :name, :author, :publisher, :price,:average_rating, :stock, :created_at, :updated_at,
json.url book_url(book, format: :json)
